

%s --> [a],s,[b].
%s --> [a],s.
%s --> [a].
%
%
%ss(List,Rest) :-
%    aa(List,List2),
%    ss(List2,List3),
%    bb(List3,Rest).
%
%ss([a,b|Rest],Rest).
%
%aa([a|Rest],Rest).
%bb([b|Rest],Rest).


%move(move(Step)) --> step(Step).
%move(move(Step,Move)) --> step(Step), move(Move).
%
%step(step(up)) --> [up].
%step(step(down)) --> [down].


%move(D) --> step(D1), move(D2), {D is D1+D2}.
%move(D) --> step(D).
%
%step(-1) --> [down].
%step(1) --> [up].


move(X0,X) --> step(DX), {X is X0+DX, safe(X),safe(X0)}.
move(X0,X) -->
    step(DX), {X1 is X0+DX, safe(X1), safe(X0)}, move(X1,X).

step(1) --> [r].
step(-1) --> [l].

safe(X) :- 
    X>0,
    X<10.

 

s( N, Dir) --> num(N).
s( N1, inc) --> num(N1), s(N2, inc), {N1 =< N2}.
s( N1, dec) --> num(N1), s(N2, dec), {N1 >= N2}.
num(N) --> [N], { N=1; N=2; N=3}.
