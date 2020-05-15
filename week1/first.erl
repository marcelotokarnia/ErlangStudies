-module(first).

-export([area/3, double/1, howManyEqual/3, maxThree/3,
	 mult/2, square/1, treble/1]).

treble(X) -> 3 * X.

square(X) -> X * X.

mult(X, Y) -> X * Y.

double(X) -> mult(2, X).

area(A, B, C) ->
    S = (A + B + C) / 2,
    math:sqrt(S * (S - A) * (S - B) * (S - C)).

is_zero(0) -> true;
is_zero(_) -> false.

xOr(X, X) -> false;
xOr(_, _) -> true.

maxThree(A, B, C) -> max(max(A, B), C).

howManyEqual(A, A, A) -> 3;
howManyEqual(A, A, _) -> 2;
howManyEqual(A, _, A) -> 2;
howManyEqual(_, A, A) -> 2;
howManyEqual(_, _, _) -> 1.
