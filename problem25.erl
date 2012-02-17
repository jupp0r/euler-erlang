-module(problem25).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_pow/2]).
-export([problem25/0]).

fib_max(L) ->
    fib_max(L,1,1,1).

fib_max(L,Iter,Result,_) when Result >= L ->
     {Iter,Result};
fib_max(L,Iter, Result, Next) ->
    fib_max(L,Iter+1, Next, Result + Next).

problem25() ->
    fib_max(int_pow(10,999)).

%% tests

fib_test_() ->
    [
     ?_assertEqual({1,1},fib_max(1)),
     ?_assertEqual({3,2},fib_max(2)),
     ?_assertEqual({4,3},fib_max(3)),
     ?_assertEqual({7,13},fib_max(12)),
     ?_assertEqual({12,144},fib_max(143))
    ].
