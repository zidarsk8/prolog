animal(cobra).
animal(piton).
animal(dog).

snake(cobra).
snake(piton).

likes(mary,X) :-
    animal(X),
    not snake(X),





f(_, _, Z) :-
    Z <2.


f( X, Y, Z) :- 
    X < 3,
    !,
    Y < 3,
    Z < 3.


