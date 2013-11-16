-module(problem45).
-include_lib("eunit/include/eunit.hrl").
-export([problem45/0]).

problem45() ->
    Limit = 100000,
    Triangles = generate_triangle(Limit),
    Pentagonals = generate_pentagonal(Limit),
    Hexagonals = generate_hexagonal(Limit),
    [X || X <- Triangles,
                      lists:member(X, Pentagonals),
                      lists:member(X, Hexagonals) ].


generate_triangle(N) ->
    List = lists:seq(1,N),
    [ X*(X+1) div 2 || X <- List ].

generate_pentagonal(N) ->
    List = lists:seq(1,N),
    [ X*(3*X-1) div 2 || X <- List ].

generate_hexagonal(N) ->
    List = lists:seq(1,N),
    [ X*(2*X-1) || X <- List ].

%tests
