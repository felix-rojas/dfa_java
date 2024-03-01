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

% Keyword sample
keyword("public").
keyword("private").
keyword("void").
keyword("main").
keyword("int").
keyword("float").

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
    % not(keyword(Str)),
    atom_chars(Str, Chars),
    check(Chars),!.

% dfa(Str):- keyword(Str),!.