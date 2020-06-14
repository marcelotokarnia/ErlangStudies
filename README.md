# Erlang Studies

Just a simple repository so I can store and version my progress at this course I'm taking at [FutureLearn](https://www.futurelearn.com/courses/functional-programming-erlang)

The folder structure is separated by weeks of the program

## Week One

- We learned the basics about operations, module, exports, imports, function declarations and the functional paradigm
- We built small functions with pattern matching such as 

```erlang
% first.erl
howManyEqual(A, A, A) -> 3;
howManyEqual(A, A, _) -> 2;
howManyEqual(A, _, A) -> 2;
howManyEqual(_, A, A) -> 2;
howManyEqual(_, _, _) -> 1.
```

## Week Two

- We learned about direct and tail recursion and it's impact in algorithm performance, for example

```erlang
% bits.erl
bits(1, A) -> A + 1;
bits(N, A) -> bits(N div 2, A + N rem 2).

bits(N) -> bits(N, 0).

bitsr(1) -> 1;
bitsr(N) -> bitsr(N div 2) + N rem 2.
```

- And we practiced head-tail splitting and some more complex functions such as area, enclose and perimeter in `shapes.erl`

## Week Three

On week 3 we dove into some lists functions (such as member, split, join, reverse, last) and started doing more complex recursions

The two highlights of the week were:

```erlang
% index.erl

index:processing().

% Takes a big text in `gettysburg-address.txt`
% and index each word by it's occurrences per line
% for example
% [{"foo", [{3,5}, {7,7}, {11,13}]}, {"bar", [{1,1}]}]
% this means that the word foo appears on the lines 3 to 5 (3,4,5), line 7 and line 11 to 13 (11,12,13)
% and the word bar appear on the line 1
```

```erlang
% bill.erl
bill:process().
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
```

## Week Four

This week was all about HOF (High order functions), functions receiving and/or returning functions. 

We practiced that with built in HOFs, such as lists:(map, filter, foldl, foldr) and built our own HOFs (mainly in `hof.erl`)

The highlight of the week was:

```erlang
% rps.erl
% We can interactively play rock-paper-scissors against predefined strategies with the command
rps:play(fun rps:no_repeat/1).

% or put two strategies to play against each other for a number of turns and 
% get the number of wins - losses from the perspective of the first strategy
rps:play_two(fun rps:cycle/1, fun rps:rock/1, 50).

% And even combine strategies, with a HOF strategy, such as
rps:play(rps:best_strategy([fun rps:cycle/1, fun rps:rock/1])).
```