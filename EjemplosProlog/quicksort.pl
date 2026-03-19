divide(_,[], [], []).


divide(E,[C|Resto], [C|R2], R3):- C =< E, divide(E, Resto, R2, R3).

divide(E,[C|Resto], R2, [C|R3]):- C > E, divide(E, Resto, R2, R3).


quicksort([], []).

quicksort([C|Resto], R):- divide(C, Resto, Men, May),
quicksort(Men, R1),
quicksort(May,R2), 
append(R1, [C|R2], R).



crea_lista(N, Lista):- crea_lista_aux(N, N, Lista).

crea_lista_aux(_, 0, []).

crea_lista_aux(N, A, [C|R]):- A > 0,random(0, N, C), N2 is A -1 ,crea_lista_aux(N, N2, R).
