-module(rockpc).

% rock paper scissor
-export([tournament/2]).

beat(q) -> paper;
beat(paper) -> scissors;
beat(scissors) -> rock.

result(A, A) -> 0;
result(A, B) ->
    case beat(A) == B of
        true -> -1;
        false -> 1
    end.

tournament(A, B) ->
    lists:foldl(fun (Arg, Acc) -> Acc + Arg end,
                0,
                lists:zipwith(fun result/2, A, B)).
