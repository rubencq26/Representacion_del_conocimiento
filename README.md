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

# Arboles Binarios
### Representacion arbol
```prolog
    a(Et, HijoIzq, HijoDcha)
    nil
    arbol1(a(1,a(2,nil,nil), a(3,nil,a(4,nil,nil)))).
```
### Ejercicios
```prolog
arbol1(a(1,a(2,nil,nil), a(3,nil,a(4,nil,nil)))).

cuenta_nodos_ab(nil, 0).

cuenta_nodos_ab(a(_,Hi ,Hd), R):-
    cuenta_nodos_ab(Hi, Ri),
    cuenta_nodos_ab(Hd, Rd),
    R is Ri + Rd + 1.


pertenece(E, a(E,_,_)).

pertenece(E, a(Et, Hi, _)):-
    E \= Et,
    pertenece(E, Hi).

pertenece(E, a(Et, _, Hd)):-
    E \= Et,
    pertenece(E, Hd).



crea_ab([], nil).

crea_ab([C|Resto], a(C, Ri, Rd)):-
    length(Resto, N),
    Mitad is N // 2,
    length(HijoDcha, Mitad),
    append(HijoIzq, HijoDcha, Resto),
    crea_ab(HijoIzq, Ri),
    crea_ab(HijoDcha, Rd).


crea_lista(0, []).

crea_lista(N, Lista) :-
    N > 0,
    N1 is N - 1,
    crea_lista(N1, R),
    append(R,[N], Lista).

crea_ab_n(N, Result):-
    crea_lista(N, Lista),
    crea_ab(Lista, Result).


altura(nil, 0).


altura(a(_,Izq,Der), R):-
    altura(Izq,PIzq),
    altura(Der, PDer),
    R is max(PIzq, PDer) + 1.
    


balanceado(nil).

balanceado(a(_,Izq,Der)):-
    altura(Izq,Ri),
    altura(Der, Rd),
    Dif is Ri - Rd,
    abs(Dif, Abs),
    Abs < 2,
    balanceado(Izq),
    balanceado(Der).



crea_abb(Lista, R):-
    sort(Lista, L),
    crea_ab_balanceado(L, R).

crea_ab_balanceado([], nil).
crea_ab_balanceado(L, a(Raiz, Ri, Rd)):-
    length(L, N),
    N > 0,
    Mid is N // 2,
   
    length(L_izq, Mid),
    append(L_izq, [Raiz|L_der], L), 
   
    crea_ab_balanceado(L_izq, Ri),
    crea_ab_balanceado(L_der, Rd).


inorden(nil, []).

inorden(a(Raiz, Izq, Der), Lista) :-
    inorden(Izq, L_izq),      
    inorden(Der, L_der),    
    append(L_izq, [Raiz|L_der], Lista).


pertenece_abb(E, a(E,_,_)).

pertenece_abb(E, a(Raiz, Izq, _)):-
    E < Raiz,
    pertenece_abb(E, Izq).

pertenece_abb(E, a(Raiz, _, Der)):-
    E > Raiz,
    pertenece_abb(E, Der).


hoja(a(_, nil, nil)).

lista_hojas(nil, []).

lista_hojas(a(Et, Izq, Der), [Et]):-
    hoja(a(Et, Izq, Der)).

lista_hojas(a(_, Izq, Der), R):-
    \+hoja(a(_, Izq, Der)),
    lista_hojas(Izq, HI),
    lista_hojas(Der,HD),
    append(HI, HD, R).

```

# Arboles genericos
### Representacion 
```prolog
arbol1(a(5,[ a(4,[a(6,[]), a(7, [])]), a( 8, []) ])).
```

### Ejercicios
```prolog
cuenta_nodos(a(_, ListaArboles), R2):-
    cuenta_nodos_lista_arboles(ListaArboles, R),
    R2 is R + 1.


cuenta_nodos_lista_arboles([], 0).

cuenta_nodos_lista_arboles([C|Resto], R):-
    cuenta_nodos_lista_arboles(Resto, R1),
    cuenta_nodos(C, R2),
    R is R1 + R2.






altura_ag(a(_, ListaArboles), R):-
    altura_ag_lista_arboles(ListaArboles, R1),
    R is R1 + 1.

altura_ag_lista_arboles([], 0).

altura_ag_lista_arboles([Cab|Resto], R):-
    altura_ag_lista_arboles(Resto, R1),
    altura_ag(Cab, R2),
    R is max(R1, R2).




crea_ag_lista_arboles([], []).

crea_ag_lista_arboles([Cab|Resto], [a(Cab, [])|R]):-
    crea_ag_lista_arboles(Resto, R).



crea_ag(N, [Cab|Resto],  a(Cab, R)):- length(Resto, L), L < N,
    crea_ag_lista_arboles(Resto, R).


crea_ag(N, [Cab|Resto] , a(Cab, R)):- N > 1, length(Resto, L), L >= N,
    Div is L div N,
    N2 is N - 1,
    length(Lista, N2),
    maplist(my_length(Div), Lista),
    append([L1|Lista], Resto),
    maplist(crea_ag(N), [L1|Lista], R).



my_length(N,Lista):- length(Lista,N).
```

# Sudoku
usamos la libreia clpfd
```prolog
:- use_module(library(clpfd)).
``` 

Sudoku
```
     .  .  4 | 8  .  . | .  1  7	     9  3  4 | 8  2  5 | 6  1  7	     
            |         |                      |         |
    6  7  . | 9  .  . | .  .  .	     6  7  2 | 9  1  4 | 8  5  3
            |         |                      |         |
    5  .  8 | .  3  . | .  .  4      5  1  8 | 6  3  7 | 9  2  4
    --------+---------+--------      --------+---------+--------
    3  .  . | 7  4  . | 1  .  .      3  2  5 | 7  4  8 | 1  6  9
            |         |                      |         |
    .  6  9 | .  .  . | 7  8  .      4  6  9 | 1  5  3 | 7  8  2
            |         |                      |         |
    .  .  1 | .  6  9 | .  .  5      7  8  1 | 2  6  9 | 4  3  5
    --------+---------+--------      --------+---------+--------
    1  .  . | .  8  . | 3  .  6	     1  9  7 | 5  8  2 | 3  4  6
            |         |                      |         |
    .  .  . | .  .  6 | .  9  1	     8  5  3 | 4  7  6 | 2  9  1
            |         |                      |         |
    2  4  . | .  .  1 | 5  .  .      2  4  6 | 3  9  1 | 5  7  8
   ```
   sudoku(+Matriz).
   es cierto si Matriz unifica con una matriz 9x9 que cumple las restricciones de un sudoku 9x9

   1. Puede generar un sudoku valido si Matriz es una variable libre

   2. Puede comprobar si Matriz es un sudoku valido si Matriz está instanciada.

   3. Puede encontrar los huecos que faltan si Matriz esta parcialmente instanciada.

```prolog
:- use_module(library(clpfd)).

sudoku(Rows):-
    length(Rows, 9),
    maplist(same_length(Rows), Rows),
    append(Rows, Vs), Vs ins 1..9,
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Is],
    blocks(As, Bs, Cs),
    blocks(Ds, Es, Fs),
    blocks(Gs, Hs, Is).
    


blocks([], [], []).

blocks([A, B, C|R1], [D, E, F|R2], [G, H, I|R3]):-  
    all_distinct([A,B,C,D,E,F,G,H,I]),
    blocks(R1, R2, R3).
```

### Llamada
```prolog
 sudoku(Rows), maplist(label, Rows), maplist(portray_clause, Rows).
```


## Timetabling

```prolog
:- use_module(library(clpfd)).

% =========================================================================
% 1. RECOLECCIÓN DE DATOS Y VARIABLES
% =========================================================================

% Recoge las asignaturas y les asigna una lista de variables (Slots) vacías.
requirements(Rs) :-
        Goal = class_subject_teacher_times(Class, Subject, Teacher, Number),
        setof(req(Class, Subject, Teacher, Number), Goal, Rs0),
        maplist(req_with_slots, Rs0, Rs).

req_with_slots(R, R-Slots) :- 
        R = req(_, _, _, N), 
        length(Slots, N).

% Extrae la lista de todos los grupos únicos de alumnos.
classes(Classes) :-
        setof(C, S^N^T^class_subject_teacher_times(C, S, T, N), Classes).

% Extrae la lista de todos los profesores únicos.
teachers(Teachers) :-
        setof(T, C^S^N^class_subject_teacher_times(C, S, T, N), Teachers).


% =========================================================================
% 2. PREDICADO PRINCIPAL Y RESTRICCIONES
% =========================================================================

requirements_variables(Rs, Vars) :-
        requirements(Rs),
        pairs_slots(Rs, Vars),
        slots_per_week(SPW),
        Max #= SPW - 1,
        Vars ins 0..Max,                     % Acota todas las horas de la semana
        maplist(constrain_subject, Rs),     % Orden cronológico por asignatura
        classes(Classes),
        teachers(Teachers),
        maplist(constrain_teacher(Rs), Teachers), % Evita colisiones de profesores
        maplist(constrain_class(Rs), Classes).    % Evita colisiones de alumnos


% =========================================================================
% 3. RESTRICCIONES ESPECÍFICAS
% =========================================================================

% Para cada asignatura, las horas se asignan en orden ascendente (rompe simetrías).
constrain_subject(_Req-Slots) :-
        strictly_ascending(Slots).

% Cláusula para los Alumnos: Ningún grupo puede tener dos clases a la vez.
constrain_class(Rs, Class) :-
        tfilter(class_req(Class), Rs, Sub),
        pairs_slots(Sub, Vs),
        all_different(Vs).      % Restricción FD: todas las horas deben ser distintas

% Cláusula para los Profesores: Ningún profesor puede dar dos clases a la vez.
constrain_teacher(Rs, Teacher) :-
        tfilter(teacher_req(Teacher), Rs, Sub),
        pairs_slots(Sub, Vs),
        all_different(Vs).      % Restricción FD: todas las horas deben ser distintas


% =========================================================================
% 4. PREDICADOS AUXILIARES
% =========================================================================

strictly_ascending(Ls) :- chain(#<, Ls).

class_req(C0, req(C1, _, _, _)-_, T) :- =(C0, C1, T).

teacher_req(T0, req(_, _, T1, _)-_, T) :- =(T0, T1, T).

pairs_slots(Ps, Vs) :-
        pairs_values(Ps, Vs0),
        append(Vs0, Vs).
```

