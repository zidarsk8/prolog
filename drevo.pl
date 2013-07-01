link(a,b).
link(a,d).
link(b,c).
link(b,h).
link(d,e).

root(X) :-
    \+ link(_,X).



bottom(X) :- 
    \+ link(X,_).


makeTree(X,t(X)):-
    bottom(X).

makeTree(X,T):-
    findall(C,link(X,C),Children),
    mkT(Children,SubTrees),
    T =.. [t,X|SubTrees].

mkT([],[]).

mkT([H|T],[HH|TT]) :-
    makeTree(H,HH),
    mkT(T,TT).
