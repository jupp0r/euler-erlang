-module(problem7).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[prime/1]).
-export([problem7/0]).


last_prime(N) ->
    last_prime(N,1,2).

last_prime(N,K,X) ->
    XisPrime = prime(X),
    if
        XisPrime ->
            if
                N == K ->
                    X;
                true ->
                    last_prime(N,K+1,X+1)
            end;
        true ->
            last_prime(N,K,X+1)
    end.

problem7() ->
    last_prime(10001).

%% tests
last_prime_test_() ->
    [ ?_assertEqual(2,last_prime(1)),
      ?_assertEqual(13,last_prime(6)) ].

