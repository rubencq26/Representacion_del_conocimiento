/*
aniadir_final(+Elem, +Lista, -ListaR)
es cierto cuando ListaR
unifica con una lista que contiene los mismos elementos que 
Listaa con el elemento elem al final.

*/

aniadir_final(Elem,[],[Elem]).
aniadir_final(Elem,[C|R], [C|R2]):-aniadir_final(Elem, R, R2).