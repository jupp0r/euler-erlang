-module(problem28).

-include_lib("eunit/include/eunit.hrl").

-export([problem28/0]).

problem28() ->
    spiral_sum(1001).

spiral_sum(N) ->
    lists:sum(euler_helper:generate_diagonal_sequence(N*N)).


spiral_sum_test_() ->
    [
     ?_assertEqual(101, spiral_sum(5)),
     ?_assertEqual(25, spiral_sum(3))
    ].
