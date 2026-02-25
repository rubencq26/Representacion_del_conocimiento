# Lógica de primer orden

### Comentarios en prolog
```prolog
# comentario
! comentario
/*
comentario
*/
```
---
 natural(Numero)
 
 Es cierto cuando Numero unifica con un número natural.

---


 ### Principio de Inducción Matemático
 
 Sea S un conjunto ordenable.
 
 Sea n0 el elemento mas pequeño de S.

 Quiero demostrar  que la propiedad P se cumple para todo elemento del conjunto S.

 1. P es cierta para n0.
 2. Para todo elemento mayor que n0, Si P(n-1) es cierto también lo será para P(n)


 Expresar que un numero es natural
 natural(1).
 
 natural(n-1) -> natural(n)

 ```prolog
 natural(1).
 natural(N) :- N > 1, N2 is N-1, natural(N2).
```

---



### Suma de los elementos de una lista



sum_lista(+Lista, -Resultado)
es cierto si Resultado unifica con la suma de todos los elementos de la lista

Lista en prolog

[1,2,3]

n0 = []

[Cabeza | Resto ] = [1,2,3]

Cabeza = 1

Resto = [2,3]

Principio de Inducción

```prolog
suma_lista([], 0).
suma_lista([Cabeza|Resto], R2):- suma_lista(Resto, R), R2 is R + Cabeza.
```

