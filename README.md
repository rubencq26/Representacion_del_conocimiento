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

---

/*

pertenece(?Elem, ?Lista)
es ciertp so Elem pertenece a Lista

P(n0)
para todo n>n0, P(n-1) ->P(n)

*/
```prolog
pertenece(E,[E|_]).
pertenece(R, [_|Resto]):- pertenece(R, Resto).
```

---
###Invertir una lista

invertir(+Lista, -ListaR)
es cierto cuando ListaR 
unifica con una lista qie contiene los mismos
elementos que Lista en orden inverso

```prolog
invertir([], []).
invertir([Cab|Resto], R2) :- invertir(Resto,R), append(R, [Cab], R2).
```

### Ordenacion por burbuja

```Prolog

/*
ordenada(+Lista)
    es cierto si la lista esta ordenada de menor a mayor.
*/


ordenada([]).
ordenada([_]).


ordenada([C1, C2|R]):- C1 =< C2 ,ordenada([C2|R]).

/* 
Caso base:
La Lista esta ordenada
*/

ordena_burbuja(Lista, Lista):- ordenada(Lista).




ordena_burbuja(Lista, R):- append(L1, [Elem1, Elem2|L2],Lista), Elem1 > Elem2, 
append(L1, [Elem2,Elem1|L2], Siguiente),
ordena_burbuja(Siguiente, R).

%ordena_burbuja(Lista, R):- append(_, [Elem1, Elem2|_], Lista), Elem1 =< Elem2, ordena_burbuja(Lista, R).


```


### Ordenacion por insercion
``` Prolog
ordenada([]).
ordenada([_]).


ordenada([C1, C2|R]):- C1 =< C2 ,ordenada([C2|R]).

insertar_ordenada(E,[],[E]).

insertar_ordenada(E, [C|Resto], [E, C|Resto]) :- 
    E =< C.

insertar_ordenada(E, [C|Resto], [C|R]) :- 
    E > C,
    insertar_ordenada(E, Resto, R).


ordena_insercion([], []).

ordena_insercion([C|Resto], Result):-  ordena_insercion(Resto, R), insertar_ordenada(C,R,Result).
```


### Quicksort
```Prolog
divide(_,[], [], []).


divide(E,[C|Resto], [C|R2], R3):- C =< E, divide(E, Resto, R2, R3).

divide(E,[C|Resto], R2, [C|R3]):- C > E, divide(E, Resto, R2, R3).


quicksort([], []).

quicksort([C|Resto], R):- divide(C, Resto, Men, May),
quicksort(Men, R1),
quicksort(May,R2), 
append(R1, [C|R2], R).






crea_lista(N, Lista):- crea_lista_aux(N, N, Lista).

crea_lista_aux(_, 0, []).

crea_lista_aux(N, A, [C|R]):- A >= 0,random(0, N, C), N2 is A -1 ,crea_lista_aux(N, N2, R).
```

### Crea Lista de numeros aleatorios de 0 a N de tamaño N

```Prolog

crea_lista(N, Lista):- crea_lista_aux(N, N, Lista).

crea_lista_aux(_, 0, []).

crea_lista_aux(N, A, [C|R]):- A > 0, NR is N + 1, random(1, NR, C), N2 is A -1 ,crea_lista_aux(N, N2, R).

```


### Comprimir una lista
 ```prolog
comprime([], []).
comprime([Elem], [(Elem,1)]).

comprime([Cab, Cab|Resto], [(Elem,N2)|R] ):- comprime([Cab|Resto], [(Elem,N)|R]), N2 is N + 1. 

comprime([Cab, E|Resto],  [(Cab, 1)|R]):- Cab \= E, comprime([E|Resto], R).
```

### Elemento que sale mas veces en una lista
```prolog
mas_veces(Lista, Elem, Num):-
    msort(Lista, ListaOr),
    comprime(ListaOr, Comprimido),
    mayor_n(Comprimido, Elem, Num).




mayor_n([(Elem,N)], Elem, N).

mayor_n([(Elem,N)|Resto], Elem, N):- mayor_n(Resto, _, N2), N > N2.

mayor_n([(_, N)|Resto], Elem, N2):- mayor_n(Resto, Elem, N2), N =< N2.
```
   
