parent(p,f).
parent(m,f).
parent(gpp,p).
parent(gmp,p).
parent(gpm,m).
parent(gmm,m).
parent(gpp,t).
parent(gmp,t).
parent(t,cz).
parent(p,d).
parent(w,d).
male(gpp).
male(mpm).
male(p).
male(f).
male(d).
female(gmp).
female(gmm).
female(m).
female(t).
female(w).

child(X,Y) :- parent(Y,X).
aunt(X,Y) :-
	parent(P,Y),P\==X,
	parent(GP,P),parent(GP,X),male(GP),
	parent(GM,P),parent(GM,X),female(GM),
	female(X),
	X \== Y.
cousin(X,Y) :-
	parent(P,Y),parent(S,X),P\==S,
	parent(GP,P),parent(GP,S),male(GP),
	parent(GM,P),parent(GM,S),female(GM).
half_sibling(X,Y) :-
	X\==Y,
	parent(Z,X),parent(Z,Y),
	parent(A,X),parent(B,Y),A\==B, A\==Z, B\==Z.

extract(X,[X|L],L).
extract(X,[Y|L],[Y|L1]) :-
	extract(X,L,L1).
remove(X, [], []).
remove(X, [X|L], M) :-
	remove(X, L, M).
remove(X, [Y|L], [Y|M]) :-
	remove(X, L, M), !.
