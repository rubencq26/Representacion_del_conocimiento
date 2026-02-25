/*

num_elem(+Lisra, -Resultado)
es cierto si resultado unifica con el numero de elementos de Lista.

Principio de inducción
1. num_elem([],0).
2. num_elen(n-1) -> num_elem(n).

*/

num_elem([], 0).
num_elem([_|Resto], R2):- num_elem(Resto, R), R2 is R + 1. 
