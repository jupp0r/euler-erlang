-module(problem10).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[prime/1]).
-export([problem10/0]).

sum_of_primes_below(N) ->
    sum_of_primes_below(1,N).

sum_of_primes_below(X,X) ->
    0;
sum_of_primes_below(K,N) ->
    IsPrime = prime(K),
    if
        IsPrime ->
            K;
        true ->
            0
    end + sum_of_primes_below(K+1,N).

problem10() ->
    sum_of_primes_below(2000000).
%% tests

sum_of_primes_below_test_() ->
    [ ?_assertEqual(17, sum_of_primes_below(10)),
      ?_assertEqual(10, sum_of_primes_below(6)) ].
