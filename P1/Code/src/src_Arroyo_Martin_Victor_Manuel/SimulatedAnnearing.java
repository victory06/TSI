/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src_Arroyo_Martin_Victor_Manuel;

import core.game.StateObservation;
import tools.ElapsedCpuTimer;

/**
 *
 * @author victor
 */
public class SimulatedAnnearing {
    public final int num_it;
    public Travel sol_actual;
    public double bestd;
    
    public SimulatedAnnearing(StateObservation stateObs, int niteraciones){
        sol_actual=new Travel(stateObs);
        num_it=niteraciones;
        bestd=sol_actual.getDistance();
    }
    
    public Travel SimulateAnnearing(ElapsedCpuTimer elapsedTimer){
        while(elapsedTimer.remainingTimeMillis()>5){ //Mientras no se pase del tiempo
            sol_actual.swapGemes(); //Cambio de posición dos gemas
            double dactual=sol_actual.getDistance();
            if(dactual<bestd){
                bestd=dactual;
            }else if(Math.exp(bestd-dactual)<Math.random()){ //Con cierta probabilidad deshacemos el cambio
                sol_actual.revertSwap();
            }
        }
        return sol_actual;
    }
    
}
