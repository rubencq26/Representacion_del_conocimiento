sustituir(_,_,[],[]).

/*Caso 1 la cabeza coincide con el elemento a sustituir*/
sustituir(E, S,[E|Resto], [S|R]):-sustituir(E,S,Resto, R).

/*Caso 2 la cabeza no coincide con el elemento a sustituir*/
sustituir(E,S,[C|Resto],[C|R]):-sustituir(E,S,Resto,R), C \= E.