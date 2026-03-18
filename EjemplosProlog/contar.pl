contar(_,[],0).

contar(E,[E|Resto], R2 ):-contar(E,Resto, R1), R2 is R1 +1.

contar(E,[C|Resto],R1):-contar(E,Resto,R1), C \= E.
