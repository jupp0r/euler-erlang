-module(problem4).
-include_lib("eunit/include/eunit.hrl").

-export([problem4/0]).

number_is_palindromic(X) ->
    Xstr = integer_to_list(X),
    Xstr == lists:reverse(Xstr).

create_product_list(L) ->
    lists:usort([X*Y || X <- L, Y <- L]).

problem4() ->
    L = create_product_list(lists:seq(1,999)),
    lists:max([X || X <- L, number_is_palindromic(X)]).

%% test
number_is_palindromic_test_() ->
    [ ?_assert(number_is_palindromic(1)),
      ?_assert(number_is_palindromic(11)),
      ?_assertNot(number_is_palindromic(12)),
      ?_assert(number_is_palindromic(111112223322211111)) ].

create_product_list_test_() ->
    [ ?_assertEqual(create_product_list([1]),[1]),
      ?_assertEqual(create_product_list([1,2]),[1,2,4]) ].
