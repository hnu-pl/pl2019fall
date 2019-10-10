% stlc2.pl

:- set_prolog_flag(occurs_check,true).

tm( val(K)     ) :- integer(K).
tm( var(X)     ) :- atom(X).
tm( lam(X,E)   ) :- atom(X), tm(E).
tm( app(E1,E2) ) :- tm(E1), tm(E2).

err([X|XS]) :- write(X), err(XS).
err([]    ) :- write('\n'), fail.

tyerr(XS) :- err(['TYPE ERROR: ' | XS]).
synerr(XS) :- err(['SYNTAX ERROR: ' | XS]).

lookup(X, [X:A | _], B) :- !, A=B.
lookup(X, [_ | XS],  B) :- lookup(X, XS, B).
lookup(X, [],        _) :- !, err([X,' is not defeind']).

tc(_, val(_),     int   ).
tc(G, var(X),     A     ) :- lookup(X, G, A).
tc(G, lam(X,E),   (A->B)) :- tc([X:A | G], E, B).
tc(G, app(E1,E2), B     ) :- tc(G, E1, T1), tc(G, E2, T2),
	( T1 = (A->B)
       	-> ( T2 = A -> true ; tyerr([E1:T1,' cannot be applied to ',E2:T2]) )
	; tyerr([E1:T1,' is not a fuction type']) ).

tychk(G,E,T) :- tm(E) -> tc(G,E,T) ; synerr([E,' is not a well-formed term']).

