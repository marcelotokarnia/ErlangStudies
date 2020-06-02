-module(zipwith).

-export([zip/2, zip_with/3]).

zip_with(F, A, B) when length(A) > length(B) ->
    zip_with(F, lists:droplast(A), B);
zip_with(F, A, B) when length(B) > length(A) ->
    zip_with(F, A, lists:droplast(B));
zip_with(F, A, B) ->
    lists:map(fun ({P, Q}) -> F(P, Q) end, lists:zip(A, B)).

zip(A, B) -> zip_with(fun (P, Q) -> {P, Q} end, A, B).
