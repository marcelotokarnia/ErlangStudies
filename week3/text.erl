-module(text).

-export([process/0]).

rio() ->
    "The heat bloomed                  in "
    "December\n as the      carnival  season\n "
    "                kicked into gear.   "
    " \nNearly helpless with sun and glare, "
    "I avoided Rio's brilliant \nsidewalks\n "
    "and glittering beaches,\npanting in "
    "dark     corners\n  and waiting out "
    "the inverted southern summer.\n".

space(C) -> lists:member(C, "\t\n ").

words([]) -> [];
words(Cs) ->
    Xs = drop_space(Cs),
    {W, Ws} = split_word(Xs),
    [W | words(Ws)].

drop_space([]) -> [];
drop_space([C | Cs]) ->
    case space(C) of
      true -> drop_space(Cs);
      false -> [C | Cs]
    end.

split_word([]) -> {[], []};
split_word([C | Cs]) ->
    {T, D} = split_word(Cs),
    case space(C) of
      false -> {[C | T], D};
      true -> {[], [C | Cs]}
    end.

lines([], _) -> [];
lines(Ws, N) ->
    {L, Ls} = split_lines(Ws, N), [L | lines(Ls, N)].

split_lines([], _) -> {[], []};
split_lines([W | Ws], N) ->
    L = length(W),
    case L > N of
      true -> {[], [W | Ws]};
      false ->
	  {T, D} = split_lines(Ws, N - L - 1), {[W | T], D}
    end.

process() ->
    lists:map(fun (A) -> lists:flatten(lists:join(" ", A))
	      end,
	      lines(words(rio()), 40)).
