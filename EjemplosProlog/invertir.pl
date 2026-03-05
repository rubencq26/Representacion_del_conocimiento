/* invertir(+Lista, -ListaR)
es cierto cuando ListaR 
unifica con una lista qie contiene los mismos
elementos que Lista en orden inverso
*/
invertir([], []).
invertir([Cab|Resto], R2) :- invertir(Resto,R), append(R, [Cab], R2).
