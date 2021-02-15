%Ejercicio 2
include "globals.mzn";

set of int: num_cifras=0..9;
%Array de incognitas:
array[num_cifras] of var 0..9: x;
%Count cuenta las apariciones de i en x
constraint forall(i in num_cifras)(x[i]=count(x,i));
solve satisfy;
