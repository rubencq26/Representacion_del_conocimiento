% ------------------------------------------------------
% mas_veces(+Lista, -Elem, -Num)
% es cierto cuando Elem unifica con el elemento
% que se repite mas veces en la lista Lista
% y Num unifica con el número de veces que se
% repite dicho elemento.
% ------------------------------------------------------

comprime([], []).
comprime([Elem], [(Elem,1)]).


comprime([Cab, Cab|Resto], [(Elem,N2)|R] ):- comprime([Cab|Resto], [(Elem,N)|R]), N2 is N + 1. 

comprime([Cab, E|Resto],  [(Cab, 1)|R]):- Cab \= E, comprime([E|Resto], R).
    
    





mas_veces(Lista, Elem, Num):-
    msort(Lista, ListaOr),
    comprime(ListaOr, Comprimido),
    mayor_n(Comprimido, Elem, Num).




mayor_n([(Elem,N)], Elem, N).

mayor_n([(Elem,N)|Resto], Elem, N):- mayor_n(Resto, _, N2), N > N2.

mayor_n([(_, N)|Resto], Elem, N2):- mayor_n(Resto, Elem, N2), N =< N2.
    
    