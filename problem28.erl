-module(problem28).

-include_lib("eunit/include/eunit.hrl").

-export([problem28/0]).

problem28() ->
    spiral_sum(1001).

spiral_sum(N) ->
    lists:sum(generate_diagonal_sequence(N*N)).

generate_diagonal_sequence(N) ->
    generate_diagonal_sequence(1,4,2,N).

generate_diagonal_sequence(K, _, _, Max) when K > Max ->
    [];
generate_diagonal_sequence(K,0,Step,Max) ->
    [K] ++ generate_diagonal_sequence(K + Step + 2, 3, Step + 2, Max);
generate_diagonal_sequence(K,Left,Step,Max) ->
    [K] ++ generate_diagonal_sequence(K + Step, Left - 1, Step, Max).


% tests

generate_diagonal_sequence_test_() ->
    [
     ?_assertEqual([1,3,5,7,9,13,17,21,25], generate_diagonal_sequence(25))
    ].

spiral_sum_test_() ->
    [
     ?_assertEqual(101, spiral_sum(5)),
     ?_assertEqual(25, spiral_sum(3))
    ].
