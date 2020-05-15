-module(shapes).

-export([area/1, enclose/1, perimeter/1]).

area({triangle, _, H, W}) -> H * W / 2;
area({rectangle, {_, _}, H, W}) -> H * W;
area({circle, {_, _}, R}) -> math:pi() * math:pow(R, 2).

enclose({triangle, _, H, W}) ->
    {rectangle, {W / 2, H / 2}, H, W};
enclose({rectangle, {_, _}, _, _} = R) -> R;
enclose({circle, {X, Y}, R}) ->
    {rectangle, {X, Y}, 2 * R, 2 * R}.

perimeter({triangle, BX, H, W}) ->
    math:sqrt(math:pow(W - BX, 2) + math:pow(H, 2)) +
      math:sqrt(math:pow(BX, 2) + math:pow(H, 2))
      + W;
perimeter({rectangle, {_, _}, H, W}) -> 2 * H + 2 * W;
perimeter({circle, {_, _}, R}) -> 2 * math:pi() * R.
