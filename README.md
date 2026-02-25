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
---

### Unificación

1) Dos terminos unifican si son __identicos__

```prolog
7 ?- 1 + 1 == 2.
false.
```
Dos cosas son identicas si son exactamente lo mismo caracter a caracter
```prolog
8 ?- 2 == 2.
true.
```

Los parentesis solo cambian el orden
```prolog
9 ?- (1 + 1) == 2.
false.

10 ?- (1 + 1) == 1 + 1.
true.

11 ?- 1 + ( 1 + 1)  == 1 + 1 + 1.
false.

12 ?- (1 + 1) + 1 == 1 + 1 + 1.
true.

14 ?- +(1,1) = 1 + 1.
true.
```

Tambien admite variables
```prolog
13 ?- 1 + 1 = X.
X = 1+1.

```
Para comparar si se cumple la condicion aritmetica se usa is
```prolog
15 ?- 2 is 1 + 1.
true.
```

Para realizar operaciones a los dos lados se usa =:=
```prolog
17 ?- 3 - 1 =:= 1 + 1.
true.
```

? significa que la variable puede estar libre o instnaciada

/*

---

num_elem(+Lisra, -Resultado)
es cierto si resultado unifica con el numero de elementos de Lista.

Principio de inducción
1. num_elem([],0).
2. num_elen(n-1) -> num_elem(n).

*/

num_elem([], 0).
num_elem([_|Resto], R2):- num_elem(Resto, R), R2 is R + 1. 



   
