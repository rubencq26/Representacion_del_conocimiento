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
    X = [[4,a],b,[2,c],[2,a],d,[4,e]] 
*/

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
?- dupli(X,3,Y). 
*/
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
    





