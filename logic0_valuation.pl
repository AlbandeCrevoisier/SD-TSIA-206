/*---------------------------------------------------------------*/
/* Telecom ParisTech											 */
/*                                                   Dep. INFRES */
/* Logic & Knowledge representation - Dessalles 2016             */
/* http://teaching.dessalles.fr/LRC                              */
/*---------------------------------------------------------------*/


:-op(140, fy, -).
:-op(160,xfy, [and, or, equiv, imp, impinv, nand, nor, nonimp, equiv, nonimpinv]).

is_true(V, X and Y) :- is_true(V,X), is_true(V,Y).
is_true(V, X or _) :- is_true(V,X).
is_true(V, _ or Y) :- is_true(V,Y).
is_true(V, -X) :-
	not(is_true(V, X)). % link with Prolog's negation
is_true(v0,a).

is_true(V, X) :-
	member(X,V).

valuation(V) :-
	sub_set(V, [a,b,c]).	
	
sub_set([], []).
sub_set([X|XL], [X|YL]) :-
    sub_set(XL, YL).
sub_set(XL, [_|YL]) :-
    sub_set(XL, YL).
	
