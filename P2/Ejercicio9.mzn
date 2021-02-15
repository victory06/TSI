include "globals.mzn";
% 1. Definición de variables y constantes:
set of int: NUM_TAREAS = 1..9;
array [NUM_TAREAS] of var int: duracion;
array [1..15,NUM_TAREAS] of var 0..3: trabajadores;
array [NUM_TAREAS] of var 1..3: trab;
%Esta matriz la da el enunciado:
array [1..3,NUM_TAREAS] of var int: duracionTr=array2d(1..3,NUM_TAREAS,
[4,3,3,2,4,3,1,1,2,
7,5,1,5,2,2,2,3,3,
10,7,4,8,6,1,3,5,4,
]);
array [NUM_TAREAS] of var int: t_inicios;

var int: sumatiempos;

%La duración debe ser la de algún trabajador
constraint forall (i in NUM_TAREAS)(duracion[i]=duracionTr[1,i] \/ duracion[i]=duracionTr[2,i] \/ duracion[i]=duracionTr[3,i]);

%Todas las duraciones son mayores que 1
constraint forall (i in NUM_TAREAS)(duracion[i]>=1);
%Todos los trabajadores tardan distinto tiempo en todo así que el trabajo con duracion igual al de uno de los trabajadores será de este trabajador.
constraint forall(j in 1..3)(forall (i in NUM_TAREAS)(duracion[i]=duracionTr[j,i] -> trab[i]=j));
%Nos aseguramos de que un trabajador solo esta en una tarea a la vez
constraint forall (i in 1..15)(count([trabajadores[i,j] | j in NUM_TAREAS], 1)<=1);
constraint forall (i in 1..15)(count([trabajadores[i,j] | j in NUM_TAREAS], 2)<=1);
constraint forall (i in 1..15)(count([trabajadores[i,j] | j in NUM_TAREAS], 3)<=1);

%El trabajo es de ese trabajador durante toda la duración
constraint forall (k in 1..3)(forall(j in NUM_TAREAS)(trab[j] = k -> forall(i in 0..duracionTr[k,j]-1)(trabajadores[t_inicios[j]+i,j] = trab[j])));

%Como en el ejercicio 7:
constraint forall (j in NUM_TAREAS)(count([trabajadores[i,j] | i in 1..15], trab[j])==duracion[j]);
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

constraint forall (i in NUM_TAREAS)(sumatiempos>=t_inicios[i]+duracion[i]-1);

solve minimize sumatiempos;

% 4. Definición del output (opcional)
output ["Trabajo \(i). Día de inicio: \(t_inicios[i])\n"| i in NUM_TAREAS];
output ["Tiempo total mínimo: \(sumatiempos)\n"];