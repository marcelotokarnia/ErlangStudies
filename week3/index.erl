-module(index).

-export([indexing/0, text/0]).

% Index the gettysburg-address.txt file to the format for every word
% [{"foo", [{3,5}, {7,7}, {11,13}]}, {"bar", [{1,1}]}]
% this means that the word foo appears on the lines 3 to 5 (3,4,5), line 7 and line 11 to 13 (11,12,13)
% and the word bar appear on the line 1

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

text() ->
    show_file_contents(get_file_contents("gettysburg-address.txt")).

get_file_contents(Name) ->
    {ok, File} = file:open(Name, [read]),
    Rev = get_all_lines(File, []),
    lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File, Partial) ->
    case io:get_line(File, "") of
      eof -> file:close(File), Partial;
      Line ->
	  {Strip, _} = lists:split(length(Line) - 1, Line),
	  get_all_lines(File, [Strip | Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L | Ls]) ->
    io:format("~s~n", [L]), show_file_contents(Ls);
show_file_contents([]) -> ok.

nospaces([]) -> [];
nospaces(["" | Xs]) -> nospaces(Xs);
nospaces([[] | Xs]) -> nospaces(Xs);
nospaces([X | Xs]) -> [X | nospaces(Xs)].

nopunct([]) -> [];
nopunct([X | Xs]) ->
    case lists:member(X, "\"-\\.,';:\t\n") of
      true -> nopunct(Xs);
      false -> [X | nopunct(Xs)]
    end.

lines(A, [], 0, 0, I, X) -> X;
lines(A, [], S, 0, I, X) -> X ++ [{S, I - 1}];
lines(A, [Line | T], 0, 0, I, X) ->
    case lists:member(A, Line) of
      true -> lines(A, T, I, 0, I + 1, X);
      false -> lines(A, T, 0, 0, I + 1, X)
    end;
lines(A, [Line | T], S, 0, I, X) ->
    case lists:member(A, Line) of
      true -> lines(A, T, S, 0, I + 1, X);
      false -> lines(A, T, 0, 0, I + 1, X ++ [{S, I - 1}])
    end.

lines(A, Words) -> {A, lines(A, Words, 0, 0, 1, [])}.

indexing() ->
    Content = get_file_contents("gettysburg-address.txt"),
    Words = lists:map(fun (A) ->
			      string:split(nopunct(A), " ", all)
		      end,
		      Content),
    NWords = lists:map(fun (A) -> nospaces(A) end, Words),
    UWords = nub(lists:flatmap(fun (A) -> A end, NWords)),
    lists:map(fun (A) -> lines(A, Words) end, UWords).
