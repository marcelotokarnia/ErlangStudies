-module(bits).

-export([bits/1, bitsr/1]).

bitsLoop(1, A) -> A + 1;
bitsLoop(N, A) -> bitsLoop(N div 2, A + N rem 2).

bits(N) -> bitsLoop(N, 0).

bitsr(1) -> 1;
bitsr(N) -> bitsr(N div 2) + N rem 2.
