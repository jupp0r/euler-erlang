-module(problem29).
-export([problem29/0]).
-import(euler_helper,[int_pow/2]).

problem29() ->
    length(lists:usort([int_pow(A,B) || A <- lists:seq(2,100), B <- lists:seq(2,100)])).
