% family.pl
%
%   tim sally     sam  cacy
%      \ /          \ /
%       +         .--+--.  
%       |        /   |   \
%       bob   mary josh  kate
%          \ /
%      .----+---.
%     /     |    \
%  john   jane   ted
% 

%%%%%%%%%%
%% facts
%%%%%%%%%% 

male(tim).
male(sam).
male(josh).
male(bob).
male(john).
male(ted).

female(sally).
female(cacy).
female(kate).
female(mary).
female(jane).

% parent(P,X) means P is parent of X
parent(sam, kate).
parent(cacy, kate).
parent(sam, josh).
parent(cacy, josh).
parent(sam, mary).
parent(cacy, mary).
parent(tim, bob).
parent(sally, bob).
parent(bob, john).
parent(mary, john).
parent(bob, jane).
parent(mary, jane).
parent(bob, ted).
parent(mary, ted).

%%%%%%%%%%
%% rules
%%%%%%%%%% 

father(P,X) :- parent(P,X), male(P).

mother(M,X) :- parent(M,X), female(M).

grandpa(G,X) :- parent(Y,X), father(G,Y).
grandma(G,X) :- parent(Y,X), mother(G,Y). 

ancestor(A,X) :- parent(A,X).
ancestor(A,X) :- parent(P,X), ancestor(A,P).

