/*---------------------------------------------------------------*/
/* Telecom ParisTech                                             */
/*                                                   Dep. INFRES */
/* Logic & Knowledge representation - Dessalles 2016             */
/* http://teaching.dessalles.fr/LRC                              */
/*---------------------------------------------------------------*/


:-op(140, fy, -).        
:-op(160,xfy, [and, or, imp, impinv, nand, nor, nonimp, equiv, nonimpinv]).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Conjunctive normal form %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%


/* table for unary, alpha and beta formulas */

components(- -X, X, _, unary).
components(X and Y, X, Y, alpha).
components(-(X or Y), -X, -Y, alpha).
components(X or Y, X, Y, beta).
components(-(X and Y), -X, -Y, beta).
components(X imp Y, -X, Y, beta).
components(-(X imp Y), X, -Y, alpha).
components(X impinv Y, X, -Y, beta).
components(-(X impinv Y), -X, Y, alpha).
components(X nand Y, -X, -Y, beta).
components(-(X nand Y), X, Y, alpha).
components(X nor Y, -X, -Y, alpha).
components(-(X nor Y), X, Y, beta).
components(X nonimp Y, X, -Y, alpha).
components(-(X nonimp Y), -X, Y, beta).
components(X nonimpinv Y, -X, Y, alpha).
components(-(X nonimpinv Y), X, -Y, beta).


% Predicate cnf puts more elementary processing together
cnf(Conjunction, NewConjunction) :-
	oneStep(Conjunction, C1),
	cnf(C1, NewConjunction).
cnf(C, C).


% Predicate oneStep performs one elementary processing
oneStep([-(-X) | R], [X | R]).
oneStep([C|S], [[A,B|R]| S]) :-
	components(P, A, B, beta),
	remove(P, C, R).
oneStep([P|S], [[A|S]|[B|S]]) :-
	components(P, A, B, alpha).
oneStep([ F | Rest], [ F | New_Rest ]) :-
	% nothing left to do on F
	oneStep(Rest, New_Rest).


/*------------------------------------------------*/
/* Auxiliary predicates                           */
/*------------------------------------------------*/

/* remove does as select, but removes all occurrences of X */
remove(X, L, NL) :-
	member(X,L),
	remove1(X, L, NL).
remove1(X, L, L) :-
	not(member(X,L)).
remove1(X, L, NL) :-
	select(X, L, L1),   % available in SWI-Prolog
	remove1(X, L1, NL).

prove(F) :-
	cnf([[ -F ]], CNF),
	write('CNF of -'), write(F), write(' = '),
	write(CNF), nl,
	resolve(CNF).
resolve(CNF) :-
	member([ ], CNF),
	write('This is a true formula'), nl.
resolve(CNF) :-
	write('Examining '), write(CNF), nl,
	get0(_),    % waits for user action
	select(C1, CNF, _),
	select(C2, CNF, RCNF),
	remove(P, C1, RC1),
	remove(-P, C2, RC2),
	append(RC1, RC2, RC),
	resolve([RC|RCNF]).    % one of the parent clauses is removed
