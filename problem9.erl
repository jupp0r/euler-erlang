-module(problem9).
-include_lib("eunit/include/eunit.hrl").
-export([problem9/0]).

is_pythagorean({A,B,C}) ->
    A*A + B*B == C*C.

find_sum_triplets(N) ->
    find_sum_triplets({1,2,N-3},N).

find_sum_triplets({A,B,C},N) ->
    if
        B < C ->
            [{A,B,C}] ++ find_sum_triplets({A, B + 1, C - 1}, N);
        true ->
            if
                A < C + 1 ->
                    find_sum_triplets({A + 1, A + 2, N - 2*A - 3},N);
                true ->
                    []
            end
    end.

find_pythagorean_sum_triplets(N) ->
    lists:filter(fun(X) -> is_pythagorean(X) end, find_sum_triplets(N)).

problem9() ->
    [{A,B,C}] = find_pythagorean_sum_triplets(1000),
    A*B*C.

%% tests

is_pythagorean_test_() ->
    [ ?_assert(is_pythagorean({3,4,5})),
      ?_assertNot(is_pythagorean({4,5,6})) ].

find_sum_triplets_test_() ->
    [ ?_assertEqual([{1,2,3}],find_sum_triplets(6)),
      ?_assertEqual([{1,2,5},{1,3,4}],find_sum_triplets(8)),
      ?_assertEqual([{1,2,9},{1,3,8},{1,4,7},{1,5,6},{2,3,7},{2,4,6},{3,4,5}],find_sum_triplets(12)),
      ?_assert(lists:member({3,4,5}, find_sum_triplets(12))) ].

find_pythagorean_sum_triplets_test_() ->
    [ ?_assertEqual([{3,4,5}],find_pythagorean_sum_triplets(12)) ].
