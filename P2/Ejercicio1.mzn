%Ejercicio 1. Puzzle Cripto-aritmético
include "globals.mzn";

set of int: num_let = 1..10;
%Array de incógnitas:
array[num_let] of var 0..9: cifras;
%Posiciones de cada letra en el array:
array[num_let] of string: strLetras = 
  ["T","E","S","F","D","I","N","K","R","A"];
constraint all_different(cifras);
%La estrategia es multiplicar cada incógnita para moverla
%a su posición en cada número. Esto es, por ejempo en TESTE,
%la T está en la posición de las decenas de millares, así que
%se la multiplica por 10000 para colocarla ahí. Así con el 
%resto para formar las sumas y el resultado.
constraint cifras[1]*10000+cifras[2]*1000+cifras[3]*100+
cifras[1]*10+cifras[2]+cifras[4]*10000+cifras[2]*1000
+cifras[3]*100+cifras[1]*10+cifras[2]+cifras[5]*10000+
cifras[2]*1000+cifras[6]*100+cifras[7]*10+cifras[2]==
cifras[8]*100000+cifras[9]*10000+cifras[10]*1000+
cifras[4]*100+cifras[1]*10+cifras[2];
solve satisfy;
output["\(strLetras[i]) = \(cifras[i])\n" | i in num_let];