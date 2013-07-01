% A FORMAL PROGRAM CORRECTNESS PROVER
%   
%   Adapted by I. Bratko from book: T. Amble, Logic Programming and Knowledge Engineering
%
% The outline is:
%
%   (1) The programmer supplies a program annotated with
%       precondition (Precond), postcondition (Postcond)
%       and intermediate conditions (loop invariants)
%   (2) Then verification conditions are automatically generated
%       according to the semantics of the language
%   (3) Verification conditions are proved by algebraic
%       simplication and theorem proving
%
% The verifier below only handles partial correctness and 
% does not perform any simplification. It leaves 
% verification conditions to be proved by the user.

% The following operator declarations make simple programs 
% legal Prolog objects (see example programs at end)

:- op( 990, fx, invariant).  % Announce invariant annotation
:- op( 989, xfx, while).     % A symbol of prog. language
:- op( 300, fy, not).
:- op( 980, fx, if).
:- op( 979, xfy, else).
:- op( 978, xfx, then).
:- op( 900, yfx, and).       % Conjunction
:- op( 988, xfx, do).        % A symbol of prog. language
:- op( 700, xfx, :=).        % Assignment in prog. language
:- op( 950, xfx, ==>).       % Implication


% PROGRAM CORRECTNESS PROVER

% verify0( Precond, Statement, PostCond):
%    prove that if Precond is true before Statement then
%    PostCond is true after Statement.
%    That is: the program Statement is partially correct w.r.t.
%    Precond and PostCond

verify0( Precond, Statement, PostCond)  :-
  wp( Cond, Statement, PostCond),       % Weakest precondition
  theorem( Precond ==> Cond).
 
% verify( Precond, Statement, Postcond):
%   The same as verify0, but writes out additional info. for user

verify( Precond, Statement, Postcond)  :-    % As verify0, more verbose
  nl, nl, 
  write('Precond:  '), write( Precond), nl, nl, 
  write('Program:  '), write( Statement), nl, nl,
  write('Postcond: '), write( Postcond), nl, nl,
  wp( Cond, Statement, Postcond),            % Weakest precondition
  theorem( Precond ==> Cond).

% theorem( Formula):
%   This should be automatic theorem prover
%   In our case Formula is just written out for the user to prove

theorem( T)  :-      
  write('Prove: '),
  write( T), nl, nl.


% AXIOMATIC SEMANTICS

% Here follows axiomatic semantics of our simple algorithmic language
% This is defined in terms of the wekest preconditons

% wp( Cond, Program, PostCond):
%   Cond is the weakest precondition that guarantees that
%   after Program is executed PostCond is true
 
wp( Cond, [begin, end], Cond).     % Empty program

% Sequential composition

wp( PreCond, [begin, Statement | Rest], PostCond)  :-
  wp( InterCond, [begin | Rest], PostCond),
  wp( PreCond, Statement, InterCond).

% if Cond then S1 else S2

wp( (Cond ==> TR) and (not Cond ==> TF),
    (if Cond then S1 else S2),
    PostCond)  :-
  wp( TR, S1, PostCond),
  wp( TF, S2, PostCond).

% Assignment X := Y

wp( PreCond, X := Y, PostCond)  :-
  replace( PostCond, X, Y, PreCond).    % Replace all X in PostCond with Y

% Annotated while statement:
%   invariant INV while B do S

wp( INV, invariant INV while B do S, PostCond)  :-
  wp( Cond, S, INV),
  theorem( B and INV ==> Cond),             % Within loop
  theorem( not B and INV ==> PostCond).     % Exit from loop

% replace( Term, SubTerm, NewSub, NewTerm)

replace( V, _, _, V) :-
  var( V), !.   

replace( A, A, B, B)  :-  !.

replace( Z1, A, B, Z2)  :-
  Z1 =.. [Op, X1, Y1],
  !,
  replace( X1, A, B, X2),
  replace( Y1, A, B, Y2),
  Z2 =.. [Op, X2, Y2].

replace( Z1, A, B, Z2)  :-
  Z1 =.. [Op, X1],
  !,
  replace( X1, A, B, X2),
  Z2 =.. [Op, X2].

replace( X, A, B, X).    % Otherwise


 
% EXAMPLES OF PROVING PROGRAMS CORRECT

demo1  :-       % A very simple program

  Program = [ 
               begin,
                 a  :=  b,
                 x  :=  a,
                end
            ],

  verify( (b=5),        % Precondition
          Program,
          (x > 4) ).    % Postcondition



demo2  :-   % Sum of integers between 1 and n

  Program = [
               begin, 
                 s := 0,
                 i := 0,
                 invariant  (i =< n) and (s = i * ( i + 1) / 2)
                   while  i < n  do
                   [ begin,
                      i := i + 1,
                      s := s + i,
                     end],
                 end
              ],

  verify( (n >= 0),                     % Precondition
          Program,
          s = n * ( n + 1) / 2  ).  % Postcondition


% Integer division: divide a with b, 
% rez = result of division (integer), ost = remainder

program3(          % rez := a div b, ost := a mod b

  [  begin,
      rez := 0,
      ost := a,
      invariant ( rez*b + ost = a )  and ( 0 =< ost )
        while (ost >= b) do
          [ begin, rez := rez + 1, ost := ost - b, end],
     end
  ]
         ).


demo3 :-
  program3( P),     % Integer division
  verify( 
    ( a>0 and b>0),     % Precondition
    P, 
    ( rez*b + ost = a )  and  ( 0 =< ost )  and  ( ost < b ) ). % Postcondition


% Swap values of variables a and b

program4(
  [ begin,
    t := a,
    a := b,
    b := t,
    end
  ]
  ).

demo4 :-
  program4( P),
  verify( (a = a0) and (b = b0), P, (a = b0) and (b = a0) ).

