-module(problem49).
-include_lib("eunit/include/eunit.hrl").
-export([problem49/0]).

problem49() ->
    Primes = euler_helper:calc_sieve(9999),
    lists:last([{X,Y,Z} ||        X <- Primes,
                       Permutations <- [lists:map(fun(Y) -> euler_helper:digit_list_to_int(Y) end, euler_helper:perms(euler_helper:int_to_digit_list(X)))],
                       Y <- Permutations,
                       Z <- Permutations,
                       Diff <- [3330],
                       Y == X + Diff,
                       Z == Y + Diff]).

