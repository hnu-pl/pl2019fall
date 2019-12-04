:-use_module(library(lists)).

%% https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem

% s(B,W,G,C)

start( s(w,w,w,w) ).

final( s(e,e,e,e) ).

opp(e,w).
opp(w,e).

% boat moves to the opposite side without a passenger
move( s(X,W,G,C), s(Y,W,G,C) ) :- opp(X,Y).
% take one passenger to the opposite side
move( s(X,X,G,C), s(Y,Y,G,C) ) :- opp(X,Y).
move( s(X,W,X,C), s(Y,W,Y,C) ) :- opp(X,Y).
move( s(X,W,G,X), s(Y,W,G,Y) ) :- opp(X,Y).

% safe conditions
safe( s(B,W,G,C) ) :- opp(W,G), opp(G,C).
safe( s(X,X,X,C) ).
safe( s(X,W,X,X) ).

% try queries where n=2,3,4,...
% start(S0), move(S0,S1), safe(S1), ... , move(S_{n-1},S_n), final(Sn).
%
