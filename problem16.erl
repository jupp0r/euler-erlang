-module(problem16).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_to_digit_list/1, int_pow/2]).
-export([problem16/0]).

problem16() ->
    lists:sum(int_to_digit_list(int_pow(2,1000))).

%% tests
