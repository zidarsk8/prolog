action( state( Pos1, Pos2, floor(Pos1)),
    pickup, 
    state( Pos1, Pos2, held) ). 

action( state( Pos, Pos, held),
    drop, 
    state( Pos, Pos, in_basket)).


action( state( Pos, Pos, Loc),
    push( Pos, NewPos),
    state( NewPos, NewPos, Loc)). 


action( state( Pos1, Pos2, Loc),
    go( Pos1, NewPos1),
    state( NewPos1, Pos2, Loc)).


plan( State, State, [ ]).

plan( State1, GoalState, [ Action1 | RestOfPlan]) :-
    action( State1, Action1, State2),
    plan( State2, GoalState, RestOfPlan). 



conc([],A,A).

conc([H|T],B,[H|C]):-
    conc(T,B,C).
