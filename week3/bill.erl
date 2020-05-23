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

-module(bill).

-export([process/0]).

process() -> [].
