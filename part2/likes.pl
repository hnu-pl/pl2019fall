% likes.pl

% fact
likes(john,mary).
likes(bob,mary).
likes(jane,john).
likes(mary,john).

% rule
couple(X,Y) :- likes(X,Y), likes(Y,X).
