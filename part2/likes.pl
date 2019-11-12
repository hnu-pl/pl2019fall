% likes.pl

% facts
likes(john, jane).
likes(john, mary).
likes(bob, mary).
likes(tim, jane).
likes(tim, lucy).
likes(jane, bob).
likes(mary, john).
likes(mary, tim).
likes(lucy, bob).
likes(lucy, tim).

% rule
couple(X, Y) :- likes(X, Y), likes(Y, X).
