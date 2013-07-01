


fib(N,F) :- 
    { N = 0, F = 1}
    ;
    { N = 1, F = 1}
    ;
    {
    N > 1,
    N1 = N-1,
    N2 = N-2,
    F = F1+F2
    },
    fib(N1,F1),
    fib(N2,F2).



