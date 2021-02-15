/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src_Arroyo_Martin_Victor_Manuel;

import core.game.Observation;
import core.game.StateObservation;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Random;
import tools.Vector2d;

/**
 *
 * @author victor
 */
public class Travel {
    AEstrella aEstrella;
    Vector2d fescala;
    Vector2d orientacion;
    HashMap<Integer,Vector2d> gemas;
    HashMap<Integer,Integer> distancia_gemas; 
    ArrayList<Integer> camino;
    ArrayList<Integer> anteriorCamino;
    ArrayList<Observation>[][] mundo;
    ArrayList<Integer> gem_invalid;
    ArrayList<Integer> gem_valid;


    public Travel(StateObservation stateObs){
        gemas=new HashMap<>();
        gem_invalid=new ArrayList<>();
        gem_valid=new ArrayList<>();
        distancia_gemas=new HashMap<>(); //La llave será la suma de los cuadrados de los indices
        camino= new ArrayList<>();
        anteriorCamino=new ArrayList<>();
        ArrayList<Observation> next_gem=stateObs.getResourcesPositions(stateObs.getAvatarPosition())[0];
        fescala = new Vector2d(stateObs.getWorldDimension().width / stateObs.getObservationGrid().length , 
                            stateObs.getWorldDimension().height / stateObs.getObservationGrid()[0].length);
        orientacion=stateObs.getAvatarOrientation().copy();
        mundo=stateObs.getObservationGrid();
        //Crear hash de consulta
        Vector2d sig_gema2 =  new Vector2d(stateObs.getAvatarPosition().x , 
                stateObs.getAvatarPosition().y );
        gemas.put(-1,sig_gema2); //-1 Indice posicion avatar
        for(int i=0; i<stateObs.getResourcesPositions(stateObs.getAvatarPosition())[0].size(); i++){
            sig_gema2 =  new Vector2d(next_gem.get(i).position.x , next_gem.get(i).position.y );
            gemas.put(i, sig_gema2);
        }
        sig_gema2 =  new Vector2d(stateObs.getPortalsPositions(sig_gema2)[0].get(0).position.x , 
                stateObs.getPortalsPositions(sig_gema2)[0].get(0).position.y );
        gemas.put(next_gem.size(), sig_gema2); //Indice posicion portal
        



        /////////////HASH
        int i=-1;
        gem_valid.add(i);
        Vector2d gi=new Vector2d(Math.floor(gemas.get(i).x/fescala.x), Math.floor(gemas.get(i).y/fescala.y));
        Vector2d gj;
        int indice;
        for(int j=0; j<gemas.size()-1; j++){
            aEstrella=new AEstrella(gi,orientacion);
            gj=new Vector2d(Math.floor(gemas.get(j).x/fescala.x), Math.floor(gemas.get(j).y/fescala.y));
            indice=j;
            if(!aEstrella.pathFinding(gj, mundo))
                gem_invalid.add(indice);
            else
                gem_valid.add(indice);
            distancia_gemas.put(i*1000+j,(int)aEstrella.actual.totalCost);
            distancia_gemas.put(j*1000+i,(int)aEstrella.actual.totalCost);
        }
        
        
        for(i=0; i<gemas.size()-1; i++){
            for(int j=-1; j<gemas.size()-1;j++){
                if(i!=j && gem_valid.contains(j) && gem_valid.contains(i)){
                    gi=new Vector2d(Math.floor(gemas.get(i).x/fescala.x), Math.floor(gemas.get(i).y/fescala.y));   
                    aEstrella=new AEstrella(gi,orientacion);
                    gj=new Vector2d(Math.floor(gemas.get(j).x/fescala.x), Math.floor(gemas.get(j).y/fescala.y)); 
                    aEstrella.pathFinding(gj, mundo);
                    distancia_gemas.put(i*1000+j,(int)aEstrella.actual.totalCost);
                    distancia_gemas.put(j*1000+i,(int)aEstrella.actual.totalCost);
                }
            }
        }        
        
        //Camino aleatorio
        int k;
        for(k=0; k<10; k++){
            if(!gem_invalid.contains(k))
                camino.add(k);
        }
        while(camino.size()<10){
            if(!gem_invalid.contains(k))
                camino.add(k);
            k++;
        }
        Collections.shuffle(camino);
        camino.add(0, -1);
        camino.add(next_gem.size());
        
        
        
        
    }
    
    public static <Integer,Vector2d> Integer getKeyByValue(Map<Integer,Vector2d> map, Vector2d value){
        for(Entry<Integer, Vector2d> v : map.entrySet()){
            if(Objects.equals(value, v.getValue()))
                return v.getKey();
        }
        return null;
    }
    
    
    public void swapGemes(){
        //Sólo cambiamos de 0 a numero de gemas, para asegurarnos de que
        //el portal y la posicion del avatar no cambian
        anteriorCamino=(ArrayList<Integer>) camino.clone();
        Random r=new Random();
        int pos_a, pos_b;
        int a,b;
        a=1;
        b=1;
        while(a==b){
            a = r.nextInt(gem_valid.size()-2)+1;
            b = r.nextInt(gem_valid.size()-2)+1;
        }
        
        if(camino.contains(gem_valid.get(a))){
            pos_a=camino.indexOf(gem_valid.get(a));
        }else{
            pos_a=r.nextInt(camino.size()-2)+1;
        }
        
        if(camino.contains(gem_valid.get(b))){
            pos_b=camino.indexOf(gem_valid.get(b));
        }else{
            pos_b=r.nextInt(camino.size()-2)+1;
        }
        
        camino.set(pos_a, gem_valid.get(b));
        camino.set(pos_b, gem_valid.get(a));
        
    }
    
    public void revertSwap(){
        camino=(ArrayList<Integer>) anteriorCamino.clone();
    }
    
    public double getDistance(){
        double distance=0;
        //Suma de distancias con orientacion a la derecha del camino completo
        for (int i=0; i<camino.size()-2;i++) {
            int indice=camino.get(i)*1000+camino.get(i+1);
            distance+=distancia_gemas.get(indice);
        }

        return distance;
    }
}