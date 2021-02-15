%Ejercicio 3

%creamos incognitas con valores posibles las horas disponibles
%de cada profesor
var 11..15: p1; var 11..13: p2; var 10..14: p3; 
var 10..13: p4; var 11..13: p5; var 9..15: p6; 

%Ahora la restricción es que no pueden coincidir horas
%así que tienen que ser todos distintos con todos

constraint p1!=p2 /\ p1!=p3 /\ p1!=p3 /\ p1!=p4 /\ p1!=p5 /\ p1!=p6;
constraint p2!=p3 /\ p2!=p3 /\ p2!=p4 /\ p2!=p5 /\ p2!=p6;
constraint p3!=p4 /\ p3!=p5 /\ p3!=p6;
constraint p4!=p5 /\ p4!=p6;
constraint p5!=p6;

solve satisfy;
