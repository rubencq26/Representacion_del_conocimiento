ordenada([]).
ordenada([_]).


ordenada([C1, C2|R]):- C1 =< C2 ,ordenada([C2|R]).

insertar_ordenada(E,[],[E]).

insertar_ordenada(E, [C|Resto], [E, C|Resto]) :- 
    E =< C.

insertar_ordenada(E, [C|Resto], [C|R]) :- 
    E > C,
    insertar_ordenada(E, Resto, R).


ordena_insercion(Lista, Lista):- ordenada(Lista).

ordena_insercion(Lista, R):- ordena_insercion_aux(Lista, [], R).
ordena_insercion_aux([], Acc, Acc).

ordena_insercion_aux([C| Resto], Acc, R):-insertar_ordenada(C, Acc, NuevoAcc), ordena_insercion_aux(Resto, NuevoAcc, R).