package src_Arroyo_Martin_Victor_Manuel;

import java.util.ArrayList;
import java.util.Collections;

import core.game.Observation;
import core.game.StateObservation;
import core.player.AbstractPlayer;
import java.util.Random;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.ElapsedCpuTimer;
import tools.Vector2d;

public class Agent extends AbstractPlayer{
	//Greedy Camel: 
	// 1) Busca la puerta m�s cercana. 
	// 2) Escoge la accion que minimiza la distancia del camello a la puerta.

	Vector2d fescala;
	Vector2d portal;
        //Mapa de observaciones del mundo
        ArrayList<Observation>[][] mundo;
        AEstrella aEstrella;
        boolean pathfound;
        boolean camino;
        boolean nivel2, nivel3, nivel5;
        int num_gemas;
        SimulatedAnnearing sim_an;
        Travel t;
        ArrayList<Types.ACTIONS> acciones;
        ArrayList<Types.ACTIONS> mov_aleatorio;
        ArrayList<Integer> recogidas; //Índices de las gemas ya recogidas para el nivel 5
        
	
        /**
	 * initialize all variables for the agent
	 * @param stateObs Observation of the current state.
     * @param elapsedTimer Timer when the action returned is due.
	 */
	public Agent(StateObservation stateObs, ElapsedCpuTimer elapsedTimer){
            //Obtenemos la matriz de observaciones
            mundo=stateObs.getObservationGrid();
            acciones=new ArrayList<>();
            recogidas=new ArrayList<>();
            camino=true;
            nivel3=false;
            nivel5=false;
            if(stateObs.getResourcesPositions(stateObs.getAvatarPosition())==null)
                nivel2=false;
            else if(stateObs.getNPCPositions(stateObs.getAvatarPosition())==null)
                nivel2=true;
            else
                nivel5=true;
            if(!nivel2 && !nivel5 && stateObs.getNPCPositions(stateObs.getAvatarPosition())!=null)
                nivel3=true;

            num_gemas=0;
                //Calculamos el factor de escala entre mundos (pixeles -> grid)
            fescala = new Vector2d(stateObs.getWorldDimension().width / stateObs.getObservationGrid().length , 
                            stateObs.getWorldDimension().height / stateObs.getObservationGrid()[0].length);      

            //Se crea una lista de observaciones de portales, ordenada por cercania al avatar
            ArrayList<Observation>[] posiciones = stateObs.getPortalsPositions(stateObs.getAvatarPosition());
            //Seleccionamos el portal mas proximo
            if(posiciones!=null){
                portal = posiciones[0].get(0).position;
                portal.x = Math.floor(portal.x / fescala.x);
                portal.y = Math.floor(portal.y / fescala.y);
            }
            pathfound=false;
            
            //////
            
            Vector2d or=stateObs.getAvatarOrientation();
            Vector2d avatar =  new Vector2d(stateObs.getAvatarPosition().x / fescala.x, 
                            stateObs.getAvatarPosition().y / fescala.y);
            
            
            if(!nivel2 && !nivel3 && !nivel5){
                if(!pathfound){
                    aEstrella=new AEstrella(avatar,or);
                    pathfound=aEstrella.pathFinding(portal, mundo);
                }
                if(!pathfound && aEstrella.actual.posicion.x==portal.x && aEstrella.actual.posicion.y==portal.y)
                    pathfound=true;
            }else if(nivel2){
                if(!pathfound){
                    sim_an=new SimulatedAnnearing(stateObs, 600000);
                    t=sim_an.SimulateAnnearing(elapsedTimer);
                    pathfound=true;
                }
            }else if(nivel3){
                mov_aleatorio=new ArrayList<>();
                mov_aleatorio.add(ACTIONS.ACTION_UP);
                mov_aleatorio.add(ACTIONS.ACTION_DOWN);
                mov_aleatorio.add(ACTIONS.ACTION_RIGHT);
                mov_aleatorio.add(ACTIONS.ACTION_LEFT);
                mov_aleatorio.add(ACTIONS.ACTION_NIL);
            }else if(nivel5){ 
                if(!pathfound){
                    //Se ignoran enemigos de primeras, pues se irán moviendo
                    sim_an=new SimulatedAnnearing(stateObs, 600000);
                    t=sim_an.SimulateAnnearing(elapsedTimer);
                    pathfound=true;
                }
            }
            
            
            
            
	}
        
        
        public double distancia_enemigo(Vector2d avatar, Vector2d enemigo){
            double dist_enemigo;
            dist_enemigo=Math.sqrt(Math.pow(enemigo.x-avatar.x,2)+Math.pow(enemigo.y-avatar.y,2));
            return dist_enemigo;
        }
        
        public ArrayList<ACTIONS> evitaEnemigo(Vector2d enemigo, StateObservation stateObs, ArrayList<Observation>[][] mundo){
            
            double dist_enemigo;
            Vector2d avat=new Vector2d(stateObs.getAvatarPosition().x/fescala.x, stateObs.getAvatarPosition().y/fescala.y);
            Vector2d enemig=new Vector2d(stateObs.getNPCPositions(stateObs.getAvatarPosition())[0].get(0).position.x/fescala.x, 
                stateObs.getNPCPositions(stateObs.getAvatarPosition())[0].get(0).position.y/fescala.y);
            
            dist_enemigo=distancia_enemigo(avat, enemig);
            if(dist_enemigo<=5){ //Si esta cerca del enemigo
                //Generamos posiciones adyacentes lejos del enemigo y que no sean muros
                ArrayList<Vector2d> pos_seguras=new ArrayList<>();
                //Para generar la secuencia de acciones de escape
                AEstrella mov_escape=new AEstrella(avat, stateObs.getAvatarOrientation()); 
                ArrayList<Vector2d> suma_resta=new ArrayList<>(); //Vector para sumar y restar 1 a las posiciones
                suma_resta.add(new Vector2d(1,0)); //Adyacentes
                suma_resta.add(new Vector2d(0,1));
                suma_resta.add(new Vector2d(-1,0));
                suma_resta.add(new Vector2d(0,-1));
                suma_resta.add(new Vector2d(1,1)); //Diagonales adyacentes
                suma_resta.add(new Vector2d(-1,-1));
                suma_resta.add(new Vector2d(-1,1));
                suma_resta.add(new Vector2d(1,-1));
                boolean casilla_no_diagonal=false;
                for(int i=0; i<8; i++){
                    Vector2d casilla_distancia= new Vector2d(stateObs.getAvatarPosition().x+suma_resta.get(i).x*fescala.x,
                        stateObs.getAvatarPosition().y+suma_resta.get(i).y*fescala.y);
                    Vector2d casilla=new Vector2d(stateObs.getAvatarPosition().x/fescala.x+suma_resta.get(i).x,
                        stateObs.getAvatarPosition().y/fescala.y+suma_resta.get(i).y);
                    boolean muro=false;
                    for(Observation obs : mundo[(int)casilla.x][(int)casilla.y]){
                        if(obs.itype==0)
                            muro=true;
                    }
                    enemig=new Vector2d(stateObs.getNPCPositions(casilla_distancia)[0].get(0).position.x/fescala.x, 
                            stateObs.getNPCPositions(casilla_distancia)[0].get(0).position.y/fescala.y);
                    if(!muro && distancia_enemigo(casilla, enemig)>=dist_enemigo){
                        pos_seguras.add(casilla);
                        if(i<4)
                            casilla_no_diagonal=true;
                    }
                    
                }
                
                //Si no hay un nodo seguro, quiere decir que nos rodean los enemigos en una
                //esquina sin poder salir asi que solo podemos quedarnos en el sitio a ver si se van
                if(pos_seguras.isEmpty()){
                    ArrayList<ACTIONS> solucion=new ArrayList<>();
                    solucion.add(Types.ACTIONS.ACTION_NIL);
                    return solucion;
                }else{
                    //Lo optimo seria escapar por la via mas rapida, la que no hay que cambiar la orientacion
                    //asi que vemos si esta en el vector de casillas seguras
                    Vector2d optimo=new Vector2d(stateObs.getAvatarPosition().x/fescala.x+stateObs.getAvatarOrientation().x,
                        stateObs.getAvatarPosition().y/fescala.y+stateObs.getAvatarOrientation().y);
                    boolean contiene_opt=false;
                    int indice_opt=pos_seguras.size();
                    for(int i=0; i<pos_seguras.size() && !contiene_opt; i++){
                        if(pos_seguras.get(i).x==optimo.x && pos_seguras.get(i).y==optimo.y){
                            contiene_opt=true;
                            indice_opt=i;
                        }
                    }
                    if(contiene_opt){
                        mov_escape.pathFinding(pos_seguras.get(indice_opt), mundo);
                        
                    }else{
                        //Si no se encuentra el optimo
                        if(casilla_no_diagonal){
                            mov_escape.pathFinding(pos_seguras.get(0), mundo);
                        }else{
                            Random r=new Random();
                            indice_opt = r.nextInt(pos_seguras.size());
                            mov_escape.pathFinding(pos_seguras.get(indice_opt), mundo);
                        }
                        
                    }
                    return mov_escape.actual.secuencia;
                    
                }
                    
                
            }
            return null;
        }
        
        
         
	
	
	/**
	 * return the best action to arrive faster to the closest portal
	 * @param stateObs Observation of the current state.
     * @param elapsedTimer Timer when the action returned is due.
	 * @return best	ACTION to arrive faster to the closest portal
	 */
	@Override
	public ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
        //Posicion del avatar
        Vector2d or=stateObs.getAvatarOrientation();
        Vector2d avatar =  new Vector2d(stateObs.getAvatarPosition().x / fescala.x, 
                        stateObs.getAvatarPosition().y / fescala.y);
            ///////
            if(nivel2){
                //Camino indica si debe recalcularse o no el camino
                if(camino){
                    Vector2d orient=stateObs.getAvatarOrientation().copy();
                    Vector2d g=t.gemas.get(t.camino.remove(0)).copy();
                    g.x=Math.floor(g.x/fescala.x);
                    g.y=Math.floor(g.y/fescala.y);
                    Vector2d gg;
                    if(stateObs.getAvatarResources().get(0)!=null){
                        if(stateObs.getAvatarResources().get(0)<10)
                            gg=t.gemas.get(t.camino.get(0)).copy();
                        else
                            gg=t.gemas.get(t.camino.get(t.camino.size()-1)).copy();
                    }else
                        gg=t.gemas.get(t.camino.get(0)).copy();
                    gg.x=Math.floor(gg.x/fescala.x);
                    gg.y=Math.floor(gg.y/fescala.y);
                    aEstrella=new AEstrella(g,orient);
                    aEstrella.pathFinding(gg, mundo);
                    acciones=(ArrayList<ACTIONS>) aEstrella.actual.secuencia.clone();
                    camino=false;
                    if(acciones.size()==1)
                        camino=true;
                }else{
                    if(acciones.size()==1)
                        camino=true;
                }
            //////
            }else if(!nivel2 && !nivel3 && !nivel5){
                acciones=aEstrella.actual.secuencia;
            }else if(nivel3){
                //Si aun quedan acciones es porque hay un plan de huída
                if(acciones.isEmpty()){
                    Random r=new Random();
                    int ind=r.nextInt(mov_aleatorio.size());
                    acciones=evitaEnemigo(stateObs.getNPCPositions(stateObs.getAvatarPosition())[0].get(0).position, stateObs, mundo);
                    if(acciones==null){
                        acciones=new ArrayList<>();
                        acciones.add(mov_aleatorio.get(ind));
                    }
                }
                
            }else if(nivel5){
                //Comprobamos si hay que evitar un enemigo
                ArrayList<Types.ACTIONS> evita;
                evita=evitaEnemigo(stateObs.getNPCPositions(stateObs.getAvatarPosition())[0].get(0).position, stateObs, mundo);
                for(int i=0; i<t.camino.size()-1; i++){ //-1 para no coger el portal
                    if(stateObs.getAvatarPosition().x==t.gemas.get(t.camino.get(i)).x && 
                            stateObs.getAvatarPosition().y==t.gemas.get(t.camino.get(i)).y &&
                            !recogidas.contains(t.camino.get(i)) ){
                        recogidas.add(t.camino.get(i));
                        t.camino.remove(i);
                    }
                        
                }
                
                //Si hay que evitarlo, no se busca camino entre gemas, lo primero es evitar
                if(evita!=null){
                    acciones=(ArrayList<ACTIONS>) evita.clone();
                    camino=false;
                }else{
                    camino=true;
                }
                //Buscar camino entre gemas
                if(camino){

                    Vector2d orient=stateObs.getAvatarOrientation().copy();
                    Vector2d g=stateObs.getAvatarPosition().copy();
                    g.x=Math.floor(g.x/fescala.x);
                    g.y=Math.floor(g.y/fescala.y);
                    Vector2d gg;
                    gg=t.gemas.get(t.camino.get(0)).copy();
                    gg.x=Math.floor(gg.x/fescala.x);
                    gg.y=Math.floor(gg.y/fescala.y);
                    aEstrella=new AEstrella(g,orient);
                    aEstrella.pathFinding(gg, mundo);
                    acciones=(ArrayList<ACTIONS>) aEstrella.actual.secuencia.clone();
                    camino=false;
                    //Cuando solo queda una acción, ésta se borrará y hay que clacular el camino de nuevo
                    if(acciones.size()==1)
                        camino=true;
                    
                }else{
                    if(acciones.size()==1)
                        camino=true;
                }
            }
            return acciones.remove(0);
            
        }
		
	
}
