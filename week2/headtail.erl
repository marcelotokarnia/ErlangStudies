-module(headtail).

-export([doubles/1, evens/1, head/1, maximumDirect/1,
	 maximumTail/1, median/1, modes/1, nub/1, nub2/1,
	 nubLast/1, palin/1, palindrome/1, productDirect/1,
	 productTail/1, tail/1, take/2]).

head([X | _Xs]) -> X.

tail([_X | Xs]) -> Xs.

second(Xs) -> head(tail(Xs)).

second2([_A, B | _Xs]) -> B.

productDirect([]) -> 1;
productDirect([X | Xs]) -> X * productDirect(Xs).

productLoop([], P) -> P;
productLoop([X | Xs], P) -> productLoop(Xs, P * X).

productTail([X | Xs]) -> productLoop(Xs, X).

maximumDirect([X]) -> X;
maximumDirect([X | Xs]) -> max(X, maximumDirect(Xs)).

maximumLoop([], M) -> M;
maximumLoop([X | Xs], M) -> maximumLoop(Xs, max(M, X)).

maximumTail([X | Xs]) -> maximumLoop(Xs, X).

allAreas([]) -> [];
allAreas([X | Xs]) -> [shapes:area(X) | allAreas(Xs)].

circles([]) -> [];
circles([{circle, {_, _}, _} = C | Xs]) ->
    [C | circles(Xs)];
circles([_X | Xs]) -> circles(Xs).

isInList(_A, []) -> false;
isInList(A, [A | _Xs]) -> true;
isInList(A, [_X | Xs]) -> isInList(A, Xs).

nubLoop([], L) -> L;
nubLoop([X | Xs], L) ->
    IsInList = isInList(X, L),
    case IsInList of
      true -> nubLoop(Xs, L);
      false -> nubLoop(Xs, L ++ [X])
    end.

nub(Xs) -> nubLoop(Xs, []).

removeAll(_, []) -> [];
removeAll(X, [X, Xs]) -> removeAll(X, Xs);
removeAll(X, [Y, Xs]) -> [Y | removeAll(X, Xs)].

nub2([]) -> [];
nub2([X, Xs]) -> [X | nub(removeAll(X, Xs))].

member(_, []) -> false;
member(X, [X | _]) -> true;
member(X, [_ | Xs]) -> member(X, Xs).

nubLast([]) -> [];
nubLast([X | Xs]) ->
    case member(X, Xs) of
      true -> nubLast(Xs);
      false -> [X | nubLast(Xs)]
    end.

reverseLoop([], L) -> L;
reverseLoop([X | Xs], L) -> reverseLoop(Xs, [X | L]).

palindrome(X) ->
    Reverse = reverseLoop(X, []), X == Reverse.

palin(X) -> Y = trans(X), Y == reverse(Y).

reverse(Xs) -> shunt(Xs, []).

shunt([], Ys) -> Ys;
shunt([X | Xs], Ys) -> shunt(Xs, [X | Ys]).

trans([]) -> [];
trans([X | Xs]) ->
    case member(X, "\" .,';:\t\n") of
      true -> trans(Xs);
      false -> [nocap(X) | trans(Xs)]
    end.

nocap(X) ->
    case $A =< X andalso X =< $Z of
      true -> X + 32;
      false -> X
    end.

take(_, 0) -> [];
take([], _) -> [];
take([X | Xs], N) -> [X | take(Xs, N - 1)].

howMany(_, []) -> 0;
howMany(A, [A | Xs]) -> 1 + howMany(A, Xs);
howMany(A, [_X | Xs]) -> howMany(A, Xs).

howManyEach([], M) -> [];
howManyEach([X | Xs], M) ->
    [{X, howMany(X, M)} | howManyEach(Xs, M)].

maxNub([{ID, N}], M, I) when N > M -> ID;
maxNub([{ID, N}], M, I) -> I;
maxNub([{ID, N} | Xs], M, I) when N > M ->
    maxNub(Xs, N, ID);
maxNub([{ID, N} | Xs], M, I) -> maxNub(Xs, M, I).

modes(X) ->
    NUB = nub(X), A = howManyEach(NUB, X), maxNub(A, 0, 0).

median(X) ->
    SORTED = lists:sort(X),
    REM = length(X) rem 2,
    case REM of
      1 -> lists:nth((length(X) + 1) div 2, SORTED);
      0 ->
	  (lists:nth(length(X) div 2, SORTED) +
	     lists:nth(length(X) div 2 + 1, SORTED))
	    / 2
    end.

evens([]) -> [];
evens([X | Xs]) when X rem 2 == 1 -> [X | evens(Xs)];
evens([_X | Xs]) -> evens(Xs).

doubles([]) -> [];
doubles([X | Xs]) -> [2 * X | doubles(Xs)].
