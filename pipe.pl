source(a, 7). 
source(b, 5). 
source(c, 2). 
source(d, 1).
pipe(a, f, 6). 
pipe(b, e, 8). 
pipe(c, e, 3). 
pipe(d, f, 2).
pipe(e, f, 5). 
pipe(f, g, 15). 
pipe(g, h, 12). 


down(X,Y):-
    pipe(X,Y,_).

down(X,Y):-
    pipe(Z,Y,_),
    down(X,Z).



inflow(X,IF):-
    findall(Y, (down(S,X),source(S,Y) ), Y ),
    sum(Y,IF).

 
sum([],0).
sum([H|T],S):-
    sum(T,SS),
    S is H+SS.


pipeOK(X,Y):-
    source(X,XI),!,
    pipe(X,Y,YI),
    XI=<YI.

pipeOK(X,Y):-
    inflow(X,XI),
    pipe(X,Y,YI),
    XI=<YI.
