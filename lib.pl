

conc([],A,A).
conc([H|T],B,[H|BB]) :-
    conc(T,B,BB).
