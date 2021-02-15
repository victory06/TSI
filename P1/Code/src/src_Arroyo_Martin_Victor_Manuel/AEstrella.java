/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src_Arroyo_Martin_Victor_Manuel;

import core.game.Observation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.PriorityQueue;
import ontology.Types;
import tools.Vector2d;

/**
 *
 * @author victor
 */
public class AEstrella {
    PriorityQueue<Nodo> abiertos;
    HashMap<Double,Nodo> cerrados;
    Nodo actual;

    public AEstrella(Vector2d Avatar, Vector2d or){
        actual=new Nodo(Avatar, or);
        abiertos=new PriorityQueue<>();
        
    }
    /**
     *
     * @param portal
     * @return
     */
    public boolean pathFinding(Vector2d portal, ArrayList<Observation>[][] mundo){
        
        abiertos.add(actual);
        cerrados=new HashMap<>();
        
        
        while(!abiertos.isEmpty() && (actual.posicion.x!=portal.x || actual.posicion.y!=portal.y)){
            abiertos.poll();
            cerrados.put(actual.posicion.x*1000000+actual.posicion.y*1000+actual.orientacion.x*10+actual.orientacion.y, actual);
            
            //Genero hijos de girar a la derecha, izda, arriba y abajo
            Nodo hijoDerecha=new Nodo(actual.posicion, actual.orientacion, Types.ACTIONS.ACTION_RIGHT, actual, portal );
            if(!cerrados.containsKey(hijoDerecha.posicion.x*1000000+hijoDerecha.posicion.y*1000+hijoDerecha.orientacion.x*10+hijoDerecha.orientacion.y)){
                if(mundo[(int)hijoDerecha.posicion.x][(int)hijoDerecha.posicion.y].isEmpty())
                    abiertos.add(hijoDerecha);
                else
                    for(Observation obs : mundo[(int)hijoDerecha.posicion.x][(int)hijoDerecha.posicion.y])
                        if(obs.itype==0)//Si es un muro
                            cerrados.put(hijoDerecha.posicion.x*1000000+hijoDerecha.posicion.y*1000+hijoDerecha.orientacion.x*10+hijoDerecha.orientacion.y, hijoDerecha);
                        else
                            abiertos.add(hijoDerecha);
            }else{
                //si se ha llegado a una posicion que hay en cerrados por un camino mas corto se quita y se mete en abiertos el hijo
                if(cerrados.get(hijoDerecha.posicion.x*1000000+hijoDerecha.posicion.y*1000+hijoDerecha.orientacion.x*10+hijoDerecha.orientacion.y).totalCost>hijoDerecha.totalCost){
                    cerrados.remove(hijoDerecha.posicion.x*1000000+hijoDerecha.posicion.y*1000+hijoDerecha.orientacion.x*10+hijoDerecha.orientacion.y);
                    abiertos.add(hijoDerecha);
                }
            }
            Nodo hijoIzda=new Nodo(actual.posicion, actual.orientacion, Types.ACTIONS.ACTION_LEFT, actual, portal);
            if(!cerrados.containsKey(hijoIzda.posicion.x*1000000+hijoIzda.posicion.y*1000+hijoIzda.orientacion.x*10+hijoIzda.orientacion.y)){
                if(mundo[(int)hijoIzda.posicion.x][(int)hijoIzda.posicion.y].size()==0)
                    abiertos.add(hijoIzda);
                else
                    for(Observation obs : mundo[(int)hijoIzda.posicion.x][(int)hijoIzda.posicion.y])
                        if(obs.itype==0)//Si es un muro
                            cerrados.put(hijoIzda.posicion.x*1000000+hijoIzda.posicion.y*1000+hijoIzda.orientacion.x*10+hijoIzda.orientacion.y, hijoIzda);
                        else
                            abiertos.add(hijoIzda);
            }else{
                //si se ha llegado a una posicion que hay en cerrados por un camino mas corto se quita y se mete en abiertos el hijo
                if(cerrados.get(hijoIzda.posicion.x*1000000+hijoIzda.posicion.y*1000+hijoIzda.orientacion.x*10+hijoIzda.orientacion.y).totalCost>hijoIzda.totalCost){
                    cerrados.remove(hijoIzda.posicion.x*1000000+hijoIzda.posicion.y*1000+hijoIzda.orientacion.x*10+hijoIzda.orientacion.y);
                    abiertos.add(hijoIzda);
                }
            }
            Nodo hijoUp=new Nodo(actual.posicion, actual.orientacion, Types.ACTIONS.ACTION_UP, actual, portal);
            if(!cerrados.containsKey(hijoUp.posicion.x*1000000+hijoUp.posicion.y*1000+hijoUp.orientacion.x*10+hijoUp.orientacion.y)){
                if(mundo[(int)hijoUp.posicion.x][(int)hijoUp.posicion.y].size()==0)
                    abiertos.add(hijoUp);
                else
                    for(Observation obs : mundo[(int)hijoUp.posicion.x][(int)hijoUp.posicion.y])
                        if(obs.itype==0) //Si es un muro
                            cerrados.put(hijoUp.posicion.x*1000000+hijoUp.posicion.y*1000+hijoUp.orientacion.x*10+hijoUp.orientacion.y, hijoUp);
                        else   
                            abiertos.add(hijoUp);
            }else{
                //si se ha llegado a una posicion que hay en cerrados por un camino mas corto se quita y se mete en abiertos el hijo
                if(cerrados.get(hijoUp.posicion.x*1000000+hijoUp.posicion.y*1000+hijoUp.orientacion.x*10+hijoUp.orientacion.y).totalCost>hijoUp.totalCost){
                    cerrados.remove(hijoUp.posicion.x*1000000+hijoUp.posicion.y*1000+hijoUp.orientacion.x*10+hijoUp.orientacion.y);
                    abiertos.add(hijoUp);
                }
            }
            Nodo hijoDown=new Nodo(actual.posicion, actual.orientacion, Types.ACTIONS.ACTION_DOWN, actual, portal);
            if(!cerrados.containsKey(hijoDown.posicion.x*1000000+hijoDown.posicion.y*1000+hijoDown.orientacion.x*10+hijoDown.orientacion.y)){
                if(mundo[(int)hijoDown.posicion.x][(int)hijoDown.posicion.y].size()==0)
                    abiertos.add(hijoDown);
                else
                    for(Observation obs : mundo[(int)hijoDown.posicion.x][(int)hijoDown.posicion.y])
                        if(obs.itype==0)//Si es un muro
                            cerrados.put(hijoDown.posicion.x*1000000+hijoDown.posicion.y*1000+hijoDown.orientacion.x*10+hijoDown.orientacion.y, hijoDown);
                        else
                            abiertos.add(hijoDown);
            }else{
                //si se ha llegado a una posicion que hay en cerrados por un camino mas corto se quita y se mete en abiertos el hijo
                if(cerrados.get(hijoDown.posicion.x*1000000+hijoDown.posicion.y*1000+hijoDown.orientacion.x*10+hijoDown.orientacion.y).totalCost>hijoDown.totalCost){
                    cerrados.remove(hijoDown.posicion.x*1000000+hijoDown.posicion.y*1000+hijoDown.orientacion.x*10+hijoDown.orientacion.y);
                    abiertos.add(hijoDown);
                }
   
            }
            if(!abiertos.isEmpty()){
                actual=abiertos.peek(); //cojo el abierto más prometedor
            }
        }
        return actual.posicion.x==portal.x && actual.posicion.y==portal.y;
    }
    

    
    
}
