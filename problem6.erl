-module(problem6).
-include_lib("eunit/include/eunit.hrl").
-export([problem6/0]).

sum_of_squares(L) ->
    lists:foldl(fun(X,Acc) -> Acc + X*X end, 0, L).

square_of_sums(L) ->
    X = lists:sum(L),
    X*X.

problem6() ->
    L = lists:seq(1,100),
    square_of_sums(L) - sum_of_squares(L).

%% test
sum_of_squares_test_() ->
    [ ?_assertEqual(sum_of_squares([1,2]),5),
      ?_assertEqual(sum_of_squares([3,4]),25),
      ?_assertEqual(sum_of_squares(lists:seq(1,10)),385) ].

square_of_sums_test_() ->
    [ ?_assertEqual(square_of_sums([1,2]),9),
      ?_assertEqual(square_of_sums([1,2,3]),36),
      ?_assertEqual(square_of_sums(lists:seq(1,10)),3025)].
