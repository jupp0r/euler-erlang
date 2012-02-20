-module(problem30).
-import(euler_helper,[int_pow/2,int_to_digit_list/1]).
-export([problem30/0]).

problem30() ->
    lists:sum([X || X <- lists:seq(2,1000000), X == lists:sum(lists:map(fun (N) -> int_pow(N,5) end, int_to_digit_list(X)))]).
