% https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

/*
P01 (*) Find the last element of a list.
Example:
?- my_last(X,[a,b,c,d]).
X = d
*/

    my_last([E], E).

    my_last([_|Resto], X):-
    my_last(Resto, X).

/*
P02 (*) Find the last but one element of a list.
*/

last_but_one([E, _], E).

last_but_one([_|Resto], X):-
    last_but_one(Resto, X).


/*
P03 (*) Find the K'th element of a list.
The first element in the list is number 1.
Example:
?- element_at(X,[a,b,c,d,e],3).
X = c
*/

element_at([X|_], 0, X).

element_at([_|Cola], Pos, X):-
    element_at(Cola, PosAnterior, X),
    Pos is PosAnterior + 1.


/* P04 (*) Find the number of elements of a list. */

number_of_elements([], 0).

number_of_elements([_|Resto], R):-
    number_of_elements(Resto, R2),
    R is R2 + 1.

/* P05 (*) Reverse a list. */


reverse_list([], []).

reverse_list([C|Resto], Resul):-
    reverse_list(Resto, R),
    append(R,[C], Resul).

/* P06 (*) Find out whether a list is a palindrome.
A palindrome can be read forward or backward; e.g. [x,a,m,a,x]. */

palindrome([]).
palindrome([_]).

palindrome([X|Resto]):-
    append(SubLista, [X], Resto),
    palindrome(SubLista).

% palindrome(Lista):- reverse_list(Lista, Lista).


/* P07 (**) Flatten a nested list structure.
Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).

Example:
?- my_flatten([a, [b, [c, d], e]], X).
X = [a, b, c, d, e]

Hint: Use the predefined predicates is_list/1 and append/3 */

my_flatten([], []).

my_flatten([C|Resto], R2):-
    is_list(C),
    my_flatten(C, C_Aplanada),
    my_flatten(Resto, R),
    append(C_Aplanada, R, R2).
    

my_flatten([C|Resto], [C|R]):-
    \+ is_list(C),
    my_flatten(Resto, R).



/* P08 (**) Eliminate consecutive duplicates of list elements.
If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

Example:
?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [a,b,c,a,d,e] */

compress([E],[E]).

compress([C, X|Resto], [C|R]):-
    C \= X,
    compress([X|Resto], R).

compress([C, C|Resto], R):-
    compress([C|Resto], R).



/* P09 (**) Pack consecutive duplicates of list elements into sublists.
If a list contains repeated elements they should be placed in separate sublists.

Example:
?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]] */

package([E], [[E]]).

package([C, C|Resto], [[C|A]|R]):-
    package([C|Resto], [A|R]).

package([C, X|Resto], [[C]|R]):-
    C \= X,
    package([X|Resto], R).


/* P10 (*) Run-length encoding of a list.
Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as terms [N,E] where N is the number of duplicates of the element E.

Example:
?- encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],[1,b],[2,c],[2,a],[1,d][4,e]] */

encode([X], [[X,1]]).

encode([C, C|Resto],[[C,N2]|R]):-
    encode([C|Resto], [[C, N]|R]),
    N2 is N + 1.

encode([C, X|Resto], [[C,1]|R]):-
    C \= X,
    encode([X|Resto], R).




/* P11 (*) Modified run-length encoding.
Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as [N,E] terms.

Example:
?- encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],b,[2,c],[2,a],d,[4,e]] */


encode_modified([X], [X]).

encode_modified([C, C|Resto],[[C,2]|R]):-
    encode_modified([C|Resto], [A|R]),
    \+ is_list(A).

encode_modified([C, C|Resto],[[C,N2]|R]):-
    encode_modified([C|Resto], [[C,Num]|R]),
    N2 is Num + 1.

encode_modified([C, X|Resto], [C|R]):-
    C \= X,
    encode_modified([X|Resto], R).


/* P12 (**) Decode a run-length encoded list.
Given a run-length code list generated as specified in problem P11. Construct its uncompressed version. */


decompress([], []).

decompress([[C,N]|Resto], [C|R]):-
    N > 2,
    N2 is N - 1,
    decompress([[C,N2]|Resto], R).

decompress([[C,N]|Resto], [C|R]):-
    N = 2,
    decompress([C|Resto], R).

decompress([C|Resto], [C|R]):-
    \+ is_list(C),
    decompress(Resto, R).



/* P13 (**) Run-length encoding of a list (direct solution).
Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem P09, but only count them. As in problem P11, simplify the result list by replacing the singleton terms [1,X] by X.

Example:
?- encode_direct([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],b,[2,c],[2,a],d,[4,e]] */

encode_direct([], []).
encode_direct([X|Resto], Result):-
    encode_helper(Resto, X, 1, Result).

encode_helper([X|Xs], X, N, Result):-
    N2 is N + 1,
    encode_helper(Xs, X, N2, Result).

encode_helper([X|Xs], Y, N, [Term|Result]):-
    X \= Y,
    encode_term(Y,N, Term),
    encode_helper(Xs, X, 1, Result).

encode_helper([], X, N, [Term]):-
    encode_term(X,N,Term).

encode_term(X,1,X):-!.
encode_term(X,N, [X,N]).

/* P14 (*) Duplicate the elements of a list.
Example:
?- dupli([a,b,c,c,d],X).
X = [a,a,b,b,c,c,c,c,d,d] */

dupli([],[]).

dupli([C|Resto], [C,C|R]):-
    dupli(Resto, R).

/* P15 (**) Duplicate the elements of a list a given number of times.
Example:
?- dupli([a,b,c],3,X).
X = [a,a,a,b,b,b,c,c,c]

What are the results of the goal:
?- dupli(X,3,Y). */
dupli([],_,[]).

dupli(Lista, N, Result):-
    dupli_helper(Lista, N, N, Result).


dupli_helper([], _, _,[]).

dupli_helper([C|Resto], N, Acc, [C|R]):-
    Acc > 0,
    N2 is Acc - 1,
    dupli_helper([C|Resto], N, N2, R).

dupli_helper([_|Resto], N, 0, R):-
    dupli_helper(Resto, N, N, R).



/* P16 (**) Drop every N'th element from a list.
Example:
?- drop([a,b,c,d,e,f,g,h,i,k],3,X).
X = [a,b,d,e,g,h,k]
*/

drop(Lista, N, Result):-
    drop_helper(Lista, N, N, Result).

drop_helper([], _, _, []).

drop_helper([C|Resto], N, Acc, [C|R]):-
    Acc > 1,
    N2 is Acc -1,
    drop_helper(Resto, N, N2, R).


drop_helper([_|Resto], N, 1, R):-
    drop_helper(Resto, N, N, R).

/*P17 (*) Split a list into two parts; the length of the first part is given.
Do not use any predefined predicates.

Example:
?- split([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
L1 = [a,b,c]
L2 = [d,e,f,g,h,i,k] */

split_list([], _, [], []).

split_list([C|Resto], N, [C|L1], L2):-
    N > 0,
    N2 is N - 1,
    split_list(Resto, N2, L1, L2).


split_list([C|Resto], 0, L1, [C|L2]):-
    split_list(Resto, 0, L1, L2).

    

/* P18 (**) Extract a slice from a list.
Given two indices, I and K, the slice is the list containing the elements between the I'th and K'th element of the original list (both limits included). Start counting the elements with 1.

Example:
?- slice([a,b,c,d,e,f,g,h,i,k],3,7,L).
X = [c,d,e,f,g] */


slice(Lista, I, F, Solucion):-
    In is I - 1,
    length(Descartar, In),
    append(Descartar, Resto, Lista),
    N is F - In,    
    length(Solucion, N),
    append(Solucion, _, Resto).


/*P19 (**) Rotate a list N places to the left.
Examples:
?- rotate([a,b,c,d,e,f,g,h],3,X).
X = [d,e,f,g,h,a,b,c]

?- rotate([a,b,c,d,e,f,g,h],-2,X).
X = [g,h,a,b,c,d,e,f]

Hint: Use the predefined predicates length/2 and append/3, as well as the result of problem P17. */

rotate(Lista, N, Solucion):-
    N >= 0,
    split_list(Lista, N, L1,L2),
    append(L2, L1, Solucion).

rotate(Lista, N, Solucion):-
    N < 0,
    length(Lista, Tam),
    T is Tam + N,
    split_list(Lista,T, L1, L2),
    append(L2, L1, Solucion).


/* P20 (*) Remove the K'th element from a list.
Example:
?- remove_at(X,[a,b,c,d],2,R).
X = b
R = [a,c,d] 
*/



remove_at(X, [C|Resto], N, [C|R]):-
    N > 1,
    N2 is N-1,
    remove_at(X, Resto,N2, R).

remove_at(X, [X|Resto], 1, Resto).


/* P21 (*) Insert an element at a given position into a list.
Example:
?- insert_at(alfa,[a,b,c,d],2,L).
L = [a,alfa,b,c,d]
*/

insert_at(X,[], _, [X]).

insert_at(X, Resto, 1, [X|Resto]).

insert_at(X, [C|Resto], N, [C|L]):-
    N > 1,
    N2 is N - 1,
    insert_at(X, Resto, N2, L).

/* P22 (*) Create a list containing all integers within a given range.
Example:
?- range(4,9,L).
L = [4,5,6,7,8,9]
*/

range(X,X,[X]).

range(X, Y, [X|L]):-
    Y >= X,
    Sig is X + 1,
    range(Sig, Y, L).


/* P23 (**) Extract a given number of randomly selected elements from a list.
The selected items shall be put into a result list.
Example:
?- rnd_select([a,b,c,d,e,f,g,h],3,L).
L = [e,d,a]

Hint: Use the built-in random number generator random/2 and the result of problem P20.
*/

rnd_select(_, 0, []). 


rnd_select(Lista, N, [X|R]) :-
    N > 0,
    length(Lista, Long),
    Upper is Long + 1, 
    random(1, Upper, Index),
    remove_at(X, Lista, Index, Resto),
    N1 is N - 1,
    rnd_select(Resto, N1, R).



/* P24 (*) Lotto: Draw N different random numbers from the set 1..M.
The selected numbers shall be put into a result list.
Example:
?- rnd_select(6,49,L).
L = [23,1,17,33,21,37]

Hint: Combine the solutions of problems P22 and P23. */

rnd_selecte(0, _, []).

rnd_selecte(N, X, [Num|R]):-
    N2 is N - 1,
    random(1, X, Num),
    rnd_selecte(N2, X, R).


/* P25 (*) Generate a random permutation of the elements of a list.
Example:
?- rnd_permu([a,b,c,d,e,f],L).
L = [b,a,d,c,e,f]

Hint: Use the solution of problem P23. */

rnd_permu([], []).

rnd_permu(Lista, R):-
    length(Lista, N),
    rnd_select(Lista, N, R).

