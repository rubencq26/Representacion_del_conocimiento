concatena([], Lista2, Lista2).
concatena([Cab| Resto], Lista2, [Cab|R]):- concatena(Resto, Lista2, R).