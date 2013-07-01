
rev([],[]).
rev([H|T], R) :-
    rev(T, TT),
    conc(TT,[H],R).


program( (R0 --> OutTape) ) -->
    [begin],instructs(( [R0,_] --> [_,Ret] )),[end], {rev(Ret,OutTape)}.

instructs( ( R0 --> R ) ) -->
    instr(( R0 --> R )).

instructs( ( R0 --> R ) ) -->
    instr(( R0 --> R1 )),

instructs(( R1 --> R )).

instr( ( [R0,T] --> [R,T] ) ) -->
    [ dte], { R is 2*R0}.

instr( ( [R0,T] --> [R,T] ) ) -->
    [ dto], { R is 2*R0 + 1}.

instr( ( [R0,T] --> [R,T] ) ) -->
    [ halve], { R is R0 // 2}.

instr( ( [R0,T] --> [R0,[R0|T]] ) ) -->
    [ print].
