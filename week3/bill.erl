% A supermarket billing system will take a sequence of barcodes such as

% [1234,4719,3814,1112,1113,1234]

% into a printed bill of the form

%          Erlang Stores
% Dry Sherry, 1lt...........5.40
% Fish Fingers..............1.21
% Orange Jelly..............0.56
% Hula Hoops (Giant)........1.33
% Unknown Item..............0.00
% Dry Sherry, 1lt...........5.40

% Total....................13.90

% using the data in a simple database such as

%  [  (4719, "Fish Fingers" , 121),
%     (5643, "Nappies" , 1010),
%     (3814, "Orange Jelly", 56),
%     (1111, "Hula Hoops", 21),
%     (1112, "Hula Hoops (Giant)", 133),
%     (1234, "Dry Sherry, 1lt", 540)]

-module(bill).

-export([process/0]).

my_db() ->
    [{4719, "Fish Fingers", 121},
     {5643, "Nappies", 1010},
     {3814, "Orange Jelly", 56},
     {1111, "Hula Hoops", 21},
     {1112, "Hula Hoops (Giant)", 133},
     {1234, "Dry Sherry, 1lt", 540}].

my_codes() -> [1234, 4719, 3814, 1112, 1113, 1234].

lookup(C) ->
    L = lists:filter(fun ({Code, _, _}) -> Code == C end,
                     my_db()),
    case length(L) == 0 of
        true -> {"Unknown Item", 0};
        false ->
            {_, N, P} = lists:last(L),
            {N, P}
    end.

make_bill(Codes) ->
    lists:filter(fun ({_, P}) -> P =/= 0 end,
                 lists:map(fun lookup/1, Codes)).

add_total(Bill) ->
    Total = lists:foldl(fun ({Name, Price}, Acc) ->
                                Acc + Price
                        end,
                        0,
                        Bill),
    Bill ++ [{"TOTAL", Total}].

repeat(A, B) ->
    case length(A) < 30 - length(B) of
        true -> repeat(A ++ ".", B);
        false -> A ++ B
    end.

printItem({Name, Price}) ->
    repeat(Name, io_lib:format("~.2f", [Price / 100])).

process() ->
    ["         Erlang Stores        ",
     "                              "]
        ++
        lists:map(fun printItem/1,
                  add_total(make_bill(my_codes()))).
