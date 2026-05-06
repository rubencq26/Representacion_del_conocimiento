
/* Representacion arbol
    a(Et, HijoIzq, HijoDcha)
    nil
*/


arbol1(a(1,a(2,nil,nil), a(3,nil,a(4,nil,nil)))).

cuenta_nodos_ab(nil, 0).

cuenta_nodos_ab(a(_,Hi ,Hd), R):-
    cuenta_nodos_ab(Hi, Ri),
    cuenta_nodos_ab(Hd, Rd),
    R is Ri + Rd + 1.


pertenece(E, a(E,_,_)).

pertenece(E, a(Et, Hi, _)):-
    E \= Et,
    pertenece(E, Hi).

pertenece(E, a(Et, _, Hd)):-
    E \= Et,
    pertenece(E, Hd).



crea_ab([], nil).

crea_ab([C|Resto], a(C, Ri, Rd)):-
    length(Resto, N),
    Mitad is N // 2,
    length(HijoDcha, Mitad),
    append(HijoIzq, HijoDcha, Resto),
    crea_ab(HijoIzq, Ri),
    crea_ab(HijoDcha, Rd).


crea_lista(0, []).

crea_lista(N, Lista) :-
    N > 0,
    N1 is N - 1,
    crea_lista(N1, R),
    append(R,[N], Lista).

crea_ab_n(N, Result):-
    crea_lista(N, Lista),
    crea_ab(Lista, Result).


altura(nil, 0).


altura(a(_,Izq,Der), R):-
    altura(Izq,PIzq),
    altura(Der, PDer),
    R is max(PIzq, PDer) + 1.
    


balanceado(nil).

balanceado(a(_,Izq,Der)):-
    altura(Izq,Ri),
    altura(Der, Rd),
    Dif is Ri - Rd,
    abs(Dif, Abs),
    Abs < 2,
    balanceado(Izq),
    balanceado(Der).



crea_abb(Lista, R):-
    sort(Lista, L),
    crea_ab_balanceado(L, R).

crea_ab_balanceado([], nil).
crea_ab_balanceado(L, a(Raiz, Ri, Rd)):-
    length(L, N),
    N > 0,
    Mid is N // 2,
   
    length(L_izq, Mid),
    append(L_izq, [Raiz|L_der], L), 
   
    crea_ab_balanceado(L_izq, Ri),
    crea_ab_balanceado(L_der, Rd).


inorden(nil, []).

inorden(a(Raiz, Izq, Der), Lista) :-
    inorden(Izq, L_izq),      
    inorden(Der, L_der),    
    append(L_izq, [Raiz|L_der], Lista).


pertenece_abb(E, a(E,_,_)).

pertenece_abb(E, a(Raiz, Izq, _)):-
    E < Raiz,
    pertenece_abb(E, Izq).

pertenece_abb(E, a(Raiz, _, Der)):-
    E > Raiz,
    pertenece_abb(E, Der).


hoja(a(_, nil, nil)).

lista_hojas(nil, []).

lista_hojas(a(Et, Izq, Der), [Et]):-
    hoja(a(Et, Izq, Der)).

lista_hojas(a(_, Izq, Der), R):-
    \+hoja(a(_, Izq, Der)),
    lista_hojas(Izq, HI),
    lista_hojas(Der,HD),
    append(HI, HD, R).


