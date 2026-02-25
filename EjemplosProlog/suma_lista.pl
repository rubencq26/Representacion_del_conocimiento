/*

Suma de los elementos de una lista



sum_lista(+Lista, -Resultado)
es cierto si Resultado unifica con la suma de todos los elementos de la lista

Lista en prolog

[1,2,3]
n0 = []
[Cabeza | Resto ] = [1,2,3]
Cabeza = 1
Resto = [2,3]

Principio de Inducción
*/

suma_lista([], 0).
suma_lista([Cabeza|Resto], R2):- suma_lista(Resto, R), R2 is R + Cabeza.
