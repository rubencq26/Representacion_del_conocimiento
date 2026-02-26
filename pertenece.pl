/*

pertenece(?Elem, ?Lista)
es ciertp so Elem pertenece a Lista

P(n0)
para todo n>n0, P(n-1) ->P(n)

*/

pertenece(E,[E|_]).
pertenece(R, [_|Resto]):- pertenece(R, Resto).
