
/*
ordenada(+Lista)
    es cierto si la lista esta ordenada de menor a mayor.
*/


ordenada([]).
ordenada([_]).


ordenada([C1, C2|R]):- C1 =< C2 ,ordenada([C2|R]).

/* 
Caso base:
La Lista esta ordenada
*/

ordena_burbuja(Lista, Lista):- ordenada(Lista).




ordena_burbuja(Lista, R):- append(L1, [Elem1, Elem2|L2],Lista), Elem1 > Elem2, 
append(L1, [Elem2,Elem1|L2], Siguiente),
ordena_burbuja(Siguiente, R).

%ordena_burbuja(Lista, R):- append(_, [Elem1, Elem2|_], Lista), Elem1 =< Elem2, ordena_burbuja(Lista, R).



