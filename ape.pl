/* ParisTech - Ecole Nationale Superieure des Telecommunications */
/* Dep. INFRES */
/* Introduction to Prolog - Dessalles & Yvon 2004 */

% adapted from I. Bratko - "Prolog - Programming for Artificial Intelligence"
%              Addison Wesley 1990

% An ape is expected to form a plan to grasp a hanging banana using a box.
% Possible actions are 'walk', 'climb (on the box)', 'push (the box)', 
% 'grasp (the banana)'

% description of actions - The current state is stored using a functor 'state'
% with 4 arguments: 
%	- horizontal position of the ape 
%	- vertical position of the ape
%	- position of the box
%	- status of the banana 
% 'action' has three arguments: 
% 	- Initial state
%	- Final state
%	- act

action(state(middle, on_box, X, not_holding), grasp, state(middle, on_box, X, holding)).
action(state(X, floor, X, Y), climb, state(X, on_box, X, Y)).
action(state(X, floor, X, Z), push(X, Y), state(Y, floor, Y, Z)).
action(state(X, floor, T, Z), walk(X, Y), state(Y, floor, T, Z)).

success(state(_, _,  _, holding), []).
success(State1, [Act | Plan]) :- 
	action(State1, Act, State2),
	write('Action : '), write(Act), nl, write(' --> '), write(State2), nl,
	success(State2, Plan).

go :-
	success(state(door, floor, window, not_holding), Plan).
