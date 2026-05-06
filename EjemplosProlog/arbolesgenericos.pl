arbol1(a(5,[ a(4,[a(6,[]), a(7, [])]), a( 8, []) ])).




cuenta_nodos(a(_, ListaArboles), R2):-
    cuenta_nodos_lista_arboles(ListaArboles, R),
    R2 is R + 1.


cuenta_nodos_lista_arboles([], 0).

cuenta_nodos_lista_arboles([C|Resto], R):-
    cuenta_nodos_lista_arboles(Resto, R1),
    cuenta_nodos(C, R2),
    R is R1 + R2.






altura_ag(a(_, ListaArboles), R):-
    altura_ag_lista_arboles(ListaArboles, R1),
    R is R1 + 1.

altura_ag_lista_arboles([], 0).

altura_ag_lista_arboles([Cab|Resto], R):-
    altura_ag_lista_arboles(Resto, R1),
    altura_ag(Cab, R2),
    R is max(R1, R2).




crea_ag_lista_arboles([], []).

crea_ag_lista_arboles([Cab|Resto], [a(Cab, [])|R]):-
    crea_ag_lista_arboles(Resto, R).



crea_ag(N, [Cab|Resto],  a(Cab, R)):- length(Resto, L), L < N,
    crea_ag_lista_arboles(Resto, R).


crea_ag(N, [Cab|Resto] , a(Cab, R)):- N > 1, length(Resto, L), L >= N,
    Div is L div N,
    N2 is N - 1,
    length(Lista, N2),
    maplist(my_length(Div), Lista),
    append([L1|Lista], Resto),
    maplist(crea_ag(N), [L1|Lista], R).



my_length(N,Lista):- length(Lista,N).


   