-module(pieces).

-export([pieces2D/1, pieces/2, piecesTest/0]).

% In how many pieces can you cut a 2D area with N cuts ? 

pieces2D(0) -> 1;
pieces2D(N) when N > 0 -> N + pieces2D(N - 1).

% In how many pieces can you cut a 3D volume with N cuts ? 

% N cuts
% Reference: http://www.jlmartin.faculty.ku.edu/MiniCollege2012/handout.pdf
pieces(_,0) -> 1;
pieces(0,_) -> 1;
pieces(N, D) when N>=0, D>=1 ->
  pieces(N-1,D-1) + pieces(N-1, D).

piecesTest() ->
  % Dimension 0
  1 = pieces(0,0), % 0 cuts in dimension 0
  1 = pieces(1,0), % 1 cuts in dimension 0 ¯\_(ツ)_/¯
  % Dimension 1
  1 = pieces(0,1),
  2 = pieces(1,1),
  3 = pieces(2,1),
  % Dimension 2
  1 = pieces(0,2),
  2 = pieces(1,2),
  4 = pieces(2,2),
  7 = pieces(3,2),
  11 = pieces(4,2),
  % Dimension 3
  1 = pieces(0,3),
  2 = pieces(1,3),
  4 = pieces(2,3),
  8 = pieces(3,3),
  15 = pieces(4,3),
  % Dimension 4
  1 = pieces(0,4),
  2 = pieces(1,4),
  4 = pieces(2,4),
  8 = pieces(3,4),
  16 = pieces(4,4),
  31 = pieces(5,4),
  passed.
