include "globals.mzn";
% 1. Definición de variables y constantes:
set of int: NUM_TAREAS = 1..9;
array [NUM_TAREAS] of int: nTrabajadores=[2,3,2,2,1,2,1,1,2];
array [NUM_TAREAS] of int: duracion=[7,3,1,8,2,1,1,3,2];
array [1..28,NUM_TAREAS] of var 0..3: trabajadores;
array [NUM_TAREAS] of var int: t_inicios;
var int: sumatiempos;

constraint forall (j in NUM_TAREAS)(count([trabajadores[i,j] | i in 1..28], nTrabajadores[j])==duracion[j]);
constraint forall (i in NUM_TAREAS)(t_inicios[i]>=1);
constraint t_inicios[1] = 1;
constraint t_inicios[2] >= t_inicios[1]+duracion[1];
constraint t_inicios[3] >= t_inicios[2]+duracion[2];
constraint t_inicios[4] >= t_inicios[1]+duracion[1];
constraint (t_inicios[5] >= t_inicios[3]+duracion[3]) /\ (t_inicios[5] >= t_inicios[4]+duracion[4]);
constraint (t_inicios[6] >= t_inicios[3]+duracion[3]) /\ (t_inicios[6] >= t_inicios[4]+duracion[4]);
constraint (t_inicios[7] >= t_inicios[3]+duracion[3]) /\ (t_inicios[7] >= t_inicios[4]+duracion[4]);
constraint t_inicios[8] >= t_inicios[1]+duracion[1];
constraint (t_inicios[9] >= t_inicios[6]+duracion[6]) /\ (t_inicios[9] >= t_inicios[8]+duracion[8]);

%Los para cada momento de inicio debe haber el número de trabajadores necesario:
constraint forall (j in NUM_TAREAS)(forall(i in 0..duracion[j]-1)(trabajadores[t_inicios[j]+i,j] = nTrabajadores[j]));

%Solo tenemos 3 trabajadores:
constraint forall (i in 1..28)(sum(j in NUM_TAREAS)(trabajadores[i,j])<=3);

constraint forall (i in NUM_TAREAS)(sumatiempos>=t_inicios[i]+duracion[i]-1);

solve minimize sumatiempos;

% 4. Definición del output (opcional)
output ["Trabajo \(i). Día de inicio: \(t_inicios[i])\n"| i in NUM_TAREAS];
output ["Tiempo total mínimo: \(sumatiempos)\n"];