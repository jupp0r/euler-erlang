-module(problem46).
-include_lib("eunit/include/eunit.hrl").
-export([problem46/0]).

problem46() ->
    Primes = ordsets:to_list(euler_helper:calc_sieve(10000)),
    UnevenComposites = lists:seq(9,lists:last(Primes),2) -- Primes,
    UnevenComposites -- [X || X <- UnevenComposites,
          S <- lists:map(fun(Y) -> Y*Y end, lists:seq(1,round(math:sqrt(X)))),
          P <- Primes,
          X == P + 2*S ].

