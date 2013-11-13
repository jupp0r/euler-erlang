-module(problem4).
-include_lib("eunit/include/eunit.hrl").

-export([problem4/0]).


create_product_list(L) ->
    lists:usort([X*Y || X <- L, Y <- L]).

problem4() ->
    L = create_product_list(lists:seq(1,999)),
    lists:max([X || X <- L, euler_helper:number_is_palindromic(X)]).

%% test

create_product_list_test_() ->
    [ ?_assertEqual(create_product_list([1]),[1]),
      ?_assertEqual(create_product_list([1,2]),[1,2,4]) ].
