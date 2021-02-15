/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src_Arroyo_Martin_Victor_Manuel;

import java.util.ArrayList;
import ontology.Types;
import tools.Vector2d;

/**
 *
 * @author victor
 */
public class Nodo implements Comparable<Nodo>{
    ArrayList<Types.ACTIONS> secuencia;
    public double totalCost;
    public double estimatedCost;
    public Vector2d posicion;
    public Vector2d orientacion;
    
    public Nodo(Vector2d pos, Vector2d or){
        totalCost=1.0f;
        estimatedCost=0.0f;
        secuencia=new ArrayList<Types.ACTIONS>();
        posicion=pos;
        orientacion=or;
        
    }
    
    public Nodo(Vector2d pos, Vector2d or, Types.ACTIONS act, Nodo padre, Vector2d portal){
        posicion=new Vector2d();
        estimatedCost = 0.0f;
        totalCost = 1.0f;
        posicion.x=pos.x;
        posicion.y=pos.y;
        secuencia=(ArrayList<Types.ACTIONS>) padre.secuencia.clone();
        totalCost=padre.totalCost+1; //Cada acción consume un tick, los ticks son el coste total
        estimatedCost=padre.estimatedCost;
        Vector2d abajo=new Vector2d(0.0f,1.0f);
        Vector2d arriba=new Vector2d(0.0f,-1.0f);
        Vector2d izquierda=new Vector2d(-1.0f,0.0f);
        Vector2d derecha=new Vector2d(1.0f,0.0f);
        
        //Depende de la acción tomada y la orientación que teníamos, habremos cambiado de posición o no
        if(act==Types.ACTIONS.ACTION_DOWN && or.y==abajo.y)
            posicion.y+=1;
        if(act==Types.ACTIONS.ACTION_UP && or.y==arriba.y)
            posicion.y-=1;
        if(act==Types.ACTIONS.ACTION_LEFT && or.x==izquierda.x)
            posicion.x-=1;
        if(act==Types.ACTIONS.ACTION_RIGHT && or.x==derecha.x)
            posicion.x++;
        //De orienctación cambiamos seguro
        if(act==Types.ACTIONS.ACTION_DOWN)
            orientacion=abajo;
        if(act==Types.ACTIONS.ACTION_UP)
            orientacion=arriba;
        if(act==Types.ACTIONS.ACTION_LEFT)
            orientacion=izquierda;
        if(act==Types.ACTIONS.ACTION_RIGHT)
            orientacion=derecha;

        
        secuencia.add(act);
        
        //Distancia Manhattan para coste estimado
        estimatedCost=(double)Math.abs(posicion.x - portal.x) + Math.abs(posicion.y-portal.y);
        
    }
    
    @Override
    public int compareTo(Nodo n) {
        if(this.estimatedCost + this.totalCost < n.estimatedCost + n.totalCost)
            return -1;
        if(this.estimatedCost + this.totalCost > n.estimatedCost + n.totalCost)
            return 1;
        return 0;
    }
    
    @Override
    public boolean equals(Object o)
    {
        return this.posicion.equals(((Nodo)o).posicion);
    }
}
