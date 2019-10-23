% stlc2.pl

:- set_prolog_flag(occurs_check,true).

tm( val(K)     ) :- integer(K).
tm( var(X)     ) :- atom(X).
tm( lam(X,E)   ) :- atom(X), tm(E).
tm( app(E1,E2) ) :- tm(E1), tm(E2).
tm( E1 + E2    ) :- tm(E1), tm(E2).

err([X|XS]) :- write(X), err(XS).
err([]    ) :- write('\n'), fail.

tyerr(XS) :- err(['TYPE ERROR: ' | XS]).
synerr(XS) :- err(['SYNTAX ERROR: ' | XS]).

lookup(X, [X:A | _], B) :- !, A=B.
lookup(X, [_ | XS],  B) :- lookup(X, XS, B).
lookup(X, [],        _) :- !, err([X,' is not defined']).

tc(_, val(_),     int   ).
tc(G, var(X),     A     ) :- lookup(X, G, A).
tc(G, lam(X,E),   (A->B)) :- tc([X:A | G], E, B).
tc(G, app(E1,E2), B     ) :- tc(G, E1, T1), tc(G, E2, T2),
	( T1 = (A->B)
       	-> ( T2 = A -> true ; tyerr([E1:T1,' cannot be applied to ',E2:T2]) )
	; tyerr([E1:T1,' is not a fuction type']) ).
tc(G, E1 + E2,    B     ) :- tc(G, E1, T1), tc(G, E2, T2),
	( T1 = int
       	-> ( T2 = int -> B = int ; tyerr([E1:T1,' is not int']) )
	; tyerr([E1:T1,' is not int']) ).

tychk(G,E,T) :- tm(E) -> tc(G,E,T) ; synerr([E,' is not a well-formed term']).


% ?- tychk([],var(x),T).
% x is not defined
% false.
 
% ?- tychk([],lam(x,x),T).
% SYNTAX ERROR: lam(x,x) is not a well-formed term
% false.
 
% ?- tychk([],lam(x,var(x)),T).
% T =  (_7216->_7216) .
 
% ?- tychk([],lam(x,lam(y,var(x))),T).
% T =  (_7380->_7398->_7380) .
 
% ?- tychk([],lam(x,lam(y,var(x)+var(y))),T).
% T =  (int->int->int) .
 
% ?- tychk([],app(lam(f,lam(x,app(var(f),var(x)))),val(3)),T).
% TYPE ERROR: lam(f,lam(x,app(var(f),var(x)))):((_12826->_12828)->_12826->_12828) cannot be applied to val(3):int
% false.

