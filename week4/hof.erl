-module(hof).

-export([add/1,
         compose/1,
         compose/2,
         fill/2,
         id/1,
         iterate/1,
         times/1,
         twice/1]).

add(X) -> fun (Y) -> X + Y end.

times(X) -> fun (Y) -> X * Y end.

compose(F, G) -> fun (X) -> G(F(X)) end.

compose([]) -> fun id/1;
compose([H | T]) ->
    A = compose(T),
    fun (X) -> A(H(X)) end.

twice(F) -> compose([F, F]).

id(X) -> X.

fill(_, 0) -> [];
fill(X, N) -> [X | fill(X, N - 1)].

iterate(0) -> fun id/1;
iterate(N) -> fun (F) -> compose(fill(F, N)) end.
