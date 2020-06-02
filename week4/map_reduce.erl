-module(map_reduce).

-export([doubleAll/1, evens/1, product/1]).

doubleAll(X) -> lists:map(fun (A) -> 2 * A end, X).

evens(X) ->
    lists:filter(fun (A) -> A rem 2 == 0 end, X).

product(X) ->
    lists:foldr(fun (A, Acc) -> Acc * A end, 1, X).
