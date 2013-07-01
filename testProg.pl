
program((_ --> [])) --> [begin],[end].

program((R0 --> T)) --> [begin], instrucs((R0 --> [0,T])), [end].

instrucs((R0 --> R)) --> instr((R0 --> R)).
instrucs((R0 --> R)) --> instr((R0 --> [R1,_])), instrucs((R1 --> R)).

instr((R0 --> [R,_])) --> [inc] ,{R is R0+1}.
instr((_  --> [R,[H|_]])) --> [print] ,{H is R}.
