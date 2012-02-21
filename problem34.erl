-module(problem34).
-export([problem34/0]).
-import(euler_helper,[fac/1,int_to_digit_list/1]).

problem34() ->
    lists:sum([X || X <- lists:seq(3,1000000), X == lists:sum(lists:map(fun (N) -> fac(N) end, int_to_digit_list(X)))]).
