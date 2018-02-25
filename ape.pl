/*---------------------------------------------------------------*/
/* ParisTech - Ecole Nationale Superieure des Telecommunications */
/*---------------------------------------------------------------*/
/*                                                   Dep. INFRES */
/* Introduction to Prolog - Dessalles & Yvon 2004                */
/*---------------------------------------------------------------*/

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

action(state(X,floor,T,Z), state(Y,floor,T,Z), walk(X,Y)).
action(state(middle,on_box,X,not_holding), state(middle,on_box,X,holding), grasp).
action(state(X,floor,X,Y), state(X,on_box,X,Y), climb).
action(state(X,floor,X,Z), state(Y,floor,Y,Z), push(X,Y)).


success( state(_,_, _, holding)).
success( State1) :- 
	action(State1, State2, _Act),
	success(State2).

go :-
	success(state(door, floor, window, not_holding)).


