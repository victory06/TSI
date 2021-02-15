% Ejercicio 10
include "globals.mzn";
var int: peso_max=275;
set of int: N=0..12;
array[N] of int: peso;
peso=array1d(N,[0,9,13,153,50,15,68,27,39,23,52,11,32]);
array[N] of int: preferencia;
preferencia=array1d(N,[0,150,35,200,160,60,45,60,40,30,10,70,30]);
var int: sumpeso;
var int: pref;
array [1..8] of var 0..12: objetos;

constraint sumpeso<=peso_max;
constraint alldifferent_except_0(objetos);
constraint sumpeso=sum(i in 1..8)(peso[objetos[i]]);
constraint pref=sum(i in 1..8)(preferencia[objetos[i]]);
solve maximize pref;