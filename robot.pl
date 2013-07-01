see(a,2,5).
see(d,5,5).
see(e,5,2).

on(a,b).
on(b,c).
on(c,table).
on(d,table).
on(e,table).


z(B,0) :-
    on(B,table).

z(B,XX+1) :-
    on(B,C),
    z(C,XX).



above2(B1,B2) :-
    on(B1,B2).

above2(B1,B2) :-
    on(B1,B),
    above2(B,B2).







len( [ ], 0).

len( [ _ | L], N) :-
    len( L, N0),
    N is N0 + 1.
