include "globals.mzn";
% 1. Definición de variables y constantes:
set of int: NUM_PERSONAS = 1..5;
array [NUM_PERSONAS] of var 1..5: col_casas;
array [NUM_PERSONAS] of var 6..10: regiones;
array [NUM_PERSONAS] of var 11..15: mascotas;
array [NUM_PERSONAS] of var 16..20: profesiones;
array [NUM_PERSONAS] of var 21..25: bebidas;

% 2. Definición de restricciones, todos tienen casa distintas, profesiones et.:
constraint all_different(col_casas); 
constraint all_different(regiones); 
constraint all_different(mascotas); 
constraint all_different(profesiones); 
constraint all_different(bebidas);

%a.
constraint forall(i in NUM_PERSONAS)(col_casas[i]==1 <-> regiones[i]==6);
%b.
constraint forall(i in NUM_PERSONAS)(regiones[i]==7 <-> mascotas[i]==11); 
%c.
constraint forall(i in NUM_PERSONAS)(regiones[i]==8 <-> profesiones[i]==16);
%d.
constraint forall(i in NUM_PERSONAS)(regiones[i]==9 <-> bebidas[i]==21); 
%e.
constraint regiones[1]==10;
%f.
constraint forall(i in NUM_PERSONAS)(col_casas[i]==2 <-> bebidas[i]==22);
%g.
constraint forall(i in 1..4)(col_casas[i]==3 -> col_casas[i+1]==2);
constraint col_casas[5]!=3;
%h.
constraint forall(i in NUM_PERSONAS)(profesiones[i]==17 <-> mascotas[i]==12);
%i.
constraint forall(i in NUM_PERSONAS)(col_casas[i]==4 <-> profesiones[i]==18);
%j.
constraint bebidas[3]==23;
%k.
constraint forall(i in 2..4)(regiones[i]==10 -> (col_casas[i-1]=5 \/ col_casas[i+1]=5));
constraint regiones[1]==10 -> col_casas[2]==5;
constraint regiones[5]==10 -> col_casas[4]==5;
constraint forall(i in 1..4)((regiones[i]==10 <-> col_casas[i+1]=5) \/ (regiones[i+1]==10 <-> col_casas[i]=5));
%l.
constraint forall(i in NUM_PERSONAS)(profesiones[i]==19 <-> bebidas[i]==24);
%m.
constraint forall(i in 2..4)(mascotas[i]==13 -> (profesiones[i-1]=20 \/ profesiones[i+1]=20));
constraint mascotas[1]==13 -> profesiones[2]=20;
constraint mascotas[5]==13 -> profesiones[4]=20;
%n.
constraint forall(i in 2..4)(mascotas[i]==14 -> (profesiones[i-1]=18 \/ profesiones[i+1]=18));
constraint mascotas[1]==14 -> profesiones[2]=18;
constraint mascotas[5]==14 -> profesiones[4]=18;


solve satisfy;
