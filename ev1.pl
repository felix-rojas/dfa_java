% Define the DFA states
state(q0). % initial state, no input
state(q1). % accepting state
state(q2). % has a single underscore state
state(q3). % dollar state
state(q4). % has number state
state(q5). % has > 1 underscores state

% Accepting and initial states
accepting(q1).
accepting(q4).
accepting(q5).
initial(q0).

% Define the alphabet
alphabet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,
          'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']).

% transition functions
% TODO! - add transition functions for state q5

transition(q0, X, q1) :-
    alphabet(A), % unify list to A
    member(X, A).

transition(q0, X, q2) :-
    X == '_'.

transition(q0, X, q3) :-
    X == '$'.

transition(q3, X, q3) :-
    X == '$'.

transition(q1, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q1, X, q2) :-
    X == '_'.

transition(q1, X, q4) :-
    number(X).

transition(q4, X, q4) :-
    number(X).

transition(q4, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q4, X, q2) :-
    X == '_'.

transition(q2, X, q2) :-
    X == '_'.

transition(q2, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q2, X, q4) :-
    number(X).

transition(q3, X, q1) :-
    alphabet(A),
    member(X, A).

% Base case, empty list and state accepting
accepts(State, []) :-
    accepting(State).

% iterate each head on string
accepts(State, [H|T]) :-
    transition(State, H, NextState),
    accepts(NextState, T).

% Entry point for checking input against the DFA
check(Input) :-
    initial(InitialState),
    accepts(InitialState, Input).

