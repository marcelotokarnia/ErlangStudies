-module(w2).

-export([findMax/2, findSum/2, perfect/1, test/0]).

perfectLoop(N, N, S) -> S == N;
perfectLoop(N, I, S) ->
    R = N rem I,
    case R of
      0 -> perfectLoop(N, I + 1, S + I);
      _ -> perfectLoop(N, I + 1, S)
    end.

perfect(N) -> perfectLoop(N, 1, 0).

findMaxLoop(_F, N, P, M) when P == N + 1 -> M;
findMaxLoop(F, N, I, M) ->
    R = F(I),
    C = R > M,
    case C of
      true -> findMaxLoop(F, N, I + 1, R);
      false -> findMaxLoop(F, N, I + 1, M)
    end.

findMax(F, N) -> findMaxLoop(F, N, 0, 0).

findSumLoop(_F, N, P, S) when P == N + 1 -> S;
findSumLoop(F, N, I, S) ->
    findSumLoop(F, N, I + 1, F(I) + S).

findSum(F, N) -> findSumLoop(F, N, 0, 0).

treble(X) -> 3 * X.

test() ->
    18 = findSum(fun treble/1, 3),
    18 = findSum(fun (X) -> X * 3 end, 3),
    9 = findMax(fun (X) -> X * 3 end, 3),
    ok.
