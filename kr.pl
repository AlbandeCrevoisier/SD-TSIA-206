mirror2(Left, Right) :-
    invert(Left, [ ], Right).
% the list is 'poured' into the second argument
invert([X|L1], L2, L3) :-
    invert(L1, [X|L2], L3).
% at the deepest level, the result L is merely copied
invert([ ], L, L).

palindrome(L) :-
	mirror2(L, R),
	L = R.

palindrome2(L) :- checkp2(L, []).
checkp2(L, L).
checkp2([X | L], L).
checkp2([X | L], M) :-
	checkp2(L, [X | M]).

empty(P) :-
	retract(P),
	fail,
	empty(P).
empty(P).

