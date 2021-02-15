%Ejercicio 4
include "globals.mzn";
% Variables
set of int: N = 1..4;
set of int: num_clases=0..12;
array [N,N] of var num_clases: horaGrupo;
array [N,N] of var 0..4: prof;
array [1..12] of string: clases = ["IA-G1","IA-G2","IA-G3","IA-G4","TSI-G1","TSI-G2","TSI-G3","TSI-G4","FBD-G1","FBD-G2","FBD-G3","FBD-G4"];

% Todas las clases distintas pues tienen una hora de 
% duración
constraint forall(j in N)( all_different([horaGrupo[i, j] | i in N]));

% Cada grupo con sus respectivas clases (el grupo
% i está en el aula i)
constraint forall(i in N)(horaGrupo[i, 1]==1 \/ horaGrupo[i, 1]==5 \/ horaGrupo[i, 1]==9 \/ horaGrupo[i, 1]==0);
constraint forall(i in N)(horaGrupo[i, 2]==2 \/ horaGrupo[i, 2]==6 \/ horaGrupo[i, 2]==10 \/ horaGrupo[i, 2]==0);
constraint forall(i in N)(horaGrupo[i, 3]==3 \/ horaGrupo[i, 3]==7 \/ horaGrupo[i, 3]==11 \/ horaGrupo[i, 3]==0);
constraint forall(i in N)(horaGrupo[i, 4]==4 \/ horaGrupo[i, 4]==8 \/ horaGrupo[i, 4]==12 \/ horaGrupo[i, 4]==0);

% Horas en las que los profesores no pueden dar clase:
constraint horaGrupo[2, 1]!=9 /\ horaGrupo[2, 2]!=10;
constraint horaGrupo[1, 3]!=3 /\ horaGrupo[1, 4]!=4;

% Restricciones para los profesores
constraint forall(j in N) (all_different([prof[j, i] | i in N]));
constraint forall(i,j in N)(horaGrupo[i, j]==3  \/ horaGrupo[i,j]==4 -> prof[i,j] == 4);
constraint forall(i,j in N)(horaGrupo[i, j]==9  \/ horaGrupo[i,j]==10 -> prof[i,j] == 2);
constraint forall(i,j in N)(horaGrupo[i, j]==1  \/ horaGrupo[i,j]==2 \/ horaGrupo[i,j]==5 \/ horaGrupo[i,j]==6 -> prof[i,j] == 1);
constraint forall(i,j in N)(horaGrupo[i, j]==7  \/ horaGrupo[i,j]==8 \/ horaGrupo[i,j]==11 \/ horaGrupo[i,j]==12 -> prof[i,j] == 3);

solve satisfy;

