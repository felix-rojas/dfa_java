 :- discontiguous transition/3, state/1, initial/1.

% Define the DFA states
state(keyword_check).  % initial state for kwd checking
state(p0).   % 'p' has been input as the first char

state(pu1).  % 'u' has been input
state(pu2).  % 'b' has been input
state(pu3).  % 'l' has been input
state(pu4).  % 'i' has been input
state(pu5).  % 'c' has been input

state(pr1).  % 'r' has been input
state(pr2).  % 'i' has been input
state(pr3).  % 'v' has been input
state(pr4).  % 'a' has been input
state(pr5).  % 't' has been input
state(pr6).  % 'e' has been input

state(m0).   % 'm' has been input
state(m1).   % 'a' has been input
state(m2).   % 'i' has been input
state(m3).   % 'n' has been input

state(v0).   % 'v' has been input
state(v1).   % 'o' has been input
state(v2).   % 'i' has been input
state(v3).   % 'd' has been input

state(i0).   % 'i' has been input
state(i1).   % 'n' has been input
state(i2).   % 't' has been input

% Accepting and initial states
initial(keyword_check).
kwd_accepting(pu5).
kwd_accepting(pr6).
kwd_accepting(v3).
kwd_accepting(i2).
kwd_accepting(m3).

% Common starting alphabet
kwd_alphabet(['p','m','v','i','P','M','V','I']).

transition(q0, X, keyword_check):-
    kwd_alphabet(Kwd),
    member(X,Kwd).

transition(keyword_check, X, p0):- X == 'p'; X=='P'.
transition(p0, X, pr1):-           X == 'r'; X=='R'.
transition(pr1, X, pr2):-          X == 'i'; X=='I'.
transition(pr2, X, pr3):-          X == 'v'; X=='V'.
transition(pr3, X, pr4):-          X == 'a'; X=='A'.
transition(pr4, X, pr5):-          X == 't'; X=='T'.
transition(pr5, X, pr6):-          X == 'e'; X=='E'.

transition(p0,  X, q1):-           X \= 'r', X \='R', char_type(X, alpha).
transition(pr1, X, q1):-           X \= 'i', X \='I', char_type(X, alpha).
transition(pr2, X, q1):-           X \= 'v', X \='V', char_type(X, alpha).
transition(pr3, X, q1):-           X \= 'a', X \='A', char_type(X, alpha).
transition(pr4, X, q1):-           X \= 't', X \='T', char_type(X,alpha).
transition(pr5, X, q1):-           X \= 'e', X \='E', char_type(X,alpha).
transition(pr6, X, q1):-           char_type(X,alpha).

transition(p0,  X, q4):-           char_type(X,digit).
transition(pr1, X, q4):-           char_type(X,digit).
transition(pr2, X, q4):-           char_type(X,digit).
transition(pr3, X, q4):-           char_type(X,digit).
transition(pr4, X, q4):-           char_type(X,digit).
transition(pr5, X, q4):-           char_type(X,digit).
transition(pr6, X, q4):-           char_type(X,digit).


transition(p0, X, pu1)  :- X == 'u'; X=='U'.
transition(pu1, X, pu2) :- X == 'b'; X=='B'.
transition(pu2, X, pu3) :- X == 'l'; X=='L'.
transition(pu3, X, pu4) :- X == 'i'; X=='I'.
transition(pu4, X, pu5) :- X == 'c'; X=='C'.

transition(p0, X,  q1):-           X \= 'u', X \='U', char_type(X, alpha).
transition(pu1, X, q1):-           X \= 'b', X \='B', char_type(X, alpha).
transition(pu2, X, q1):-           X \= 'l', X \='L', char_type(X, alpha).
transition(pu3, X, q1):-           X \= 'i', X \='I', char_type(X, alpha).
transition(pu4, X, q1):-           X \= 'c', X \='C', char_type(X,alpha).
transition(pu5, X, q1):-           char_type(X,alpha).

transition(p0, X,  q4):-           char_type(X, digit).
transition(pu1, X, q4):-           char_type(X, digit).
transition(pu2, X, q4):-           char_type(X, digit).
transition(pu3, X, q4):-           char_type(X, digit).
transition(pu4, X, q4):-           char_type(X, digit).
transition(pu5, X, q4):-           char_type(X, digit).

transition(keyword_check, X, m0):- X == 'm'; X=='M'.
transition(m0, X, m1):-            X == 'a'; X=='A'.
transition(m1, X, m2):-            X == 'i'; X=='I'.
transition(m2, X, m3):-            X == 'n'; X=='N'.


transition(keyword_check, X, v0):- X == 'v'; X=='V'.
transition(v0, X, v1):-            X == 'o'; X=='O'.
transition(v1, X, v2):-            X == 'i'; X=='I'.
transition(v2, X, v3):-            X == 'd'; X=='D'.

transition(keyword_check, X, i0):- X == 'i'; X=='I'.
transition(i0, X, i1):-            X == 'n'; X=='N'.
transition(i1, X, i2):-            X == 't'; X=='T'.


% Define the DFA states
state(q0). % initial state, no keywords
state(q1). % alphabet state
state(q2). % has a single beginning underscore state
state(q3). % dollar state
state(q4). % has number state
state(q5). % has > 1 underscores state

% Accepting and initial states
initial(q0).

accepting(q1).
accepting(q3). % any number of $ are valid identifiers
accepting(q4). 
accepting(q5).

% transition functions

transition(q0, X, q1) :-
    char_type(X,alpha).

transition(q0, X, q2) :-
    X == '_'.

transition(q0, X, q3) :-
    X == '$'.

transition(q1, X, q1) :-
    char_type(X,alpha).

transition(q1, X, q3) :-
    X == '$'.

transition(q1, X, q4) :-
    char_type(X,digit).

transition(q1, X, q5) :-
    X == '_'.

transition(q2, X, q1) :-
    char_type(X,alpha).

transition(q2, X, q3) :-
    X == '$'.

transition(q2, X, q4) :-
    char_type(X,digit).

transition(q2, X, q5) :-
    X == '_'.

transition(q3, X, q1) :-
    char_type(X,alpha).

transition(q3, X, q3) :-
    X == '$'.
    
transition(q3, X, q4) :-
    char_type(X,digit).

transition(q3, X, q5) :-
    X == '_'.

transition(q4, X, q1) :-
    char_type(X,alpha).

transition(q4, X, q2) :-
    X == '_'.

transition(q4, X, q4) :-
    char_type(X,digit).

transition(q4, X, q5) :-
    X == '_'.

transition(q5, X, q1) :-
    char_type(X,alpha).

transition(q5, X, q3) :-
    X == '$'.

transition(q5, X, q4) :-
    char_type(X,digit).

transition(q5, X, q5) :-
    X == '_'.


% Base case, empty list and state accepting

accepts(State, []) :-
    kwd_accepting(State),!,
    write("Keyword state, not an identifier\n").

accepts(State, []) :-
    accepting(State),
    write("Accepted state\n").

% iterate each head on string
accepts(State, [H|T]) :-
    transition(State, H, NextState),
    accepts(NextState, T).

% Entry point for checking input against the DFA
check(Input) :-
    initial(InitialState),
    accepts(InitialState, Input).

dfa(Str):-
    atom_chars(Str, Chars),
    check(Chars),!.