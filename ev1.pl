% Define the DFA states
state(q0). % initial state, no input
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

% Define the alphabet
alphabet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,
          'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']).

% Keywords
keyword("public").
keyword("private").
keyword("void").
keyword("main").
keyword("int").
keyword("float").

% transition functions

transition(q0, X, q1) :-
    alphabet(A), % unify list to A
    member(X, A).

transition(q0, X, q2) :-
    X == '_'.

transition(q0, X, q3) :-
    X == '$'.

transition(q1, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q1, X, q5) :-
    X == '_'.

transition(q1, X, q3) :-
    X == '$'.

transition(q1, X, q4) :-
    char_type(X,digit).

transition(q2, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q2, X, q3) :-
    X == '$'.

transition(q2, X, q4) :-
    char_type(X,digit).

transition(q2, X, q5) :-
    X == '_'.

transition(q3, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q3, X, q5) :-
    X == '_'.

transition(q3, X, q3) :-
    X == '$'.

transition(q3, X, q4) :-
    char_type(X,digit).

transition(q4, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q4, X, q2) :-
    X == '_'.

transition(q4, X, q4) :-
    char_type(X,digit).

transition(q5, X, q1) :-
    alphabet(A),
    member(X, A).

transition(q5, X, q3) :-
    X == '$'.

transition(q5, X, q4) :-
    char_type(X,digit).

transition(q5, X, q5) :-
    X == '_'.


% Base case, empty list and state accepting
accepts(State, []) :-
    accepting(State),!.

% iterate each head on string
accepts(State, [H|T]) :-
    transition(State, H, NextState),
    accepts(NextState, T).

% Entry point for checking input against the DFA
check(Input) :-
    initial(InitialState),
    accepts(InitialState, Input).

dfa(Str):-
    not(keyword(Str)),
    atom_chars(Str, Chars),
    check(Chars),!.

dfa(Str):- keyword(Str),!.