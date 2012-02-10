-module(problem48).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_pow_fun/3, int_pow/2]).
-export([problem48/0]).

problem48() ->
    lists:foldl(fun(X, Acc) -> Acc + int_pow_fun(X,X,fun(Y) -> Y rem int_pow(10,10) end) end, 0, lists:seq(1,1000)) rem int_pow(10,10).

%% tests

