eliminar_elemento_lista(_,[],[]).

/* El elemento coincide */
eliminar_elemento_lista(E,[E|Resto], R):- eliminar_elemento_lista(E,Resto, R).

/* El elemento no coincide*/

eliminar_elemento_lista(E,[C|Resto], [C|R]):- eliminar_elemento_lista(E,Resto, R), C \= E.