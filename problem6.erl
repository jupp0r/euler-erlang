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
    [ ?_assertEqual(5,sum_of_squares([1,2])),
      ?_assertEqual(25,sum_of_squares([3,4])),
      ?_assertEqual(385,sum_of_squares(lists:seq(1,10))) ].

square_of_sums_test_() ->
    [ ?_assertEqual(9,square_of_sums([1,2])),
      ?_assertEqual(36,square_of_sums([1,2,3])),
      ?_assertEqual(3025,square_of_sums(lists:seq(1,10)))].
