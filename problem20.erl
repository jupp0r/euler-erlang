-module(problem20).
-import(euler_helper,[int_to_digit_list/1, fac/1]).
-export([problem20/0]).

problem20() ->
    lists:sum(int_to_digit_list(fac(100))).
