lista_divisores(_, 1, [1]).

lista_divisores(X, Y, [Y|R]):-
    Y > 1,
    Y2 is Y - 1,
    0 is X mod Y,
    lista_divisores(X, Y2, R).

lista_divisores(X, Y, R):-
    Y > 1,
    Y2 is Y -1,
    \+ 0  is X mod Y,
    lista_divisores(X, Y2, R).




primo(X):- lista_divisores(X,X, R),
    R  == [X, 1].   



lista_primos(X, X, [X]):- primo(X).

lista_primos(X, X, []).

lista_primos(X, Y, [Y|R]):-
    primo(Y),
    Y2 is Y -1,
    lista_primos(X, Y2, R).


lista_primos(X, Y, R):-
    \+ primo(Y),
    Y2 is Y - 1,
    lista_primos(X, Y2, R).