

hasValue([],_,[]).

hasValue([H|T],Val,[B|TT]):-
    H = (B=Val),!,
    hasValue(T,Val,TT).

hasValue([_|T], Val, TT):-
    hasValue(T, Val, TT).


sorted([]).
sorted([_]).

sorted([(_=A),(_=B)|T]):-
    A=<B,
    sorted([(_B=B)|T]).







conc([],A,A).
conc([H|T],A,[H|TA]):-
    conc(T,A,TA).

genL(_,0,[]).
genL(A,N,[A|T]):-
    N>0,
    NN is N-1,
    genL(A,NN,T).

generate(X,[X]):-
    atom(X).

generate(X,Res):-
    compound(X),
    X =.. [+, Arg1, Arg2],
    generate(Arg1,R1),
    generate(Arg2,R2),
    conc(R1,R2,Res).

generate(X,Res):-
    compound(X),
    X =.. [*, Arg1, Arg2],
    atomic(Arg1),
    atom(Arg2),
    genL(Arg2,Arg1,Res).



pf( X, P):-
    P #> 1,
    P #< X,
    X #= P * _,
    indomain(P).
    



    
c([A,B|T],C) :- !,
    {A + B =< C},
    c([B|T],C).

c(_,C) :-
    minimize(C).

