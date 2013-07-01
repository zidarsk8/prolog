max( X, none, X).
max( X, Y, X) :- X >= Y.
max( X, Y, Y) :- X < Y.

min( X, none, X).
min( X, Y, X) :- X<Y.
min( X, Y, Y) :- Y=< X.

tree(nil,none,none).

tree(b(L,E,R),A,B):-
    tree(R,A1,B1),
    min(E,A1,A2),
    max(E,B1,B2),
    tree(L,A3,B3),
    min(A2,A3,A),
    max(B2,B3,B).


    
