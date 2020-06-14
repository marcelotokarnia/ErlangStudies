-module(bits).

-export([bits/1, bitsr/1]).

% Define a function bits/1 that takes a positive
% integer N and returns the sum of the bits in the binary
% representation. For example bits(7) is 3 and bits(8) is 1.

bits(1, A) -> A + 1;
bits(N, A) -> bits(N div 2, A + N rem 2).

bits(N) -> bits(N, 0).

bitsr(1) -> 1;
bitsr(N) -> bitsr(N div 2) + N rem 2.
