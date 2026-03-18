es_natural(0).
es_natural(N):- N > 1, N2 is N-1, es_natural(N2).