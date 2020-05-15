-module(second).

-export([hipo/2, triangle/2]).

hipo(A, B) -> first:square(A) + first:square(B).

triangle(A, B) -> first:mult(A, B) / 2.
