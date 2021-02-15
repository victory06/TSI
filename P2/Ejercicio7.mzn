% Ejercicio 7
include "globals.mzn";
%Variables conocidas:
set of int: NUM_TAREAS = 1..9;
array [NUM_TAREAS] of int: duracion=[7,3,1,8,2,1,1,3,2];
%Variables solucion
var int: sumatiempos;
array [NUM_TAREAS] of var int: t_inicios;


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


constraint sumatiempos==t_inicios[9]+duracion[9];

solve minimize sumatiempos;