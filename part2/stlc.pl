% stlc.pl

:- set_prolog_flag(occurs_check,true).

lookup(X, [X:A|_], B) :- !, A=B.
lookup(X, [_|XS], B) :- lookup(X, XS, B).

tc(_, val(_), int).
tc(G, var(X), A) :- lookup(X, G, A).
tc(G, lam(X,E), (A->B)) :- tc([X:A|G], E, B).
tc(G, app(E1,E2), B) :- tc(G, E1, (A->B)), tc(G, E2, A).
