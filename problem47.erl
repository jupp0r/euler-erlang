-module(problem47).

-export([problem47/0]).
-include_lib("eunit/include/eunit.hrl").

problem47() ->
    search_n_prime_divisor_numbers(4).

search_n_prime_divisor_numbers(N) ->
    search_n_prime_divisor_numbers(N,2).

search_n_prime_divisor_numbers(N,K) ->
    case number_of_prime_divisors(K) of
        N ->
            case lists:all(fun(X) -> number_of_prime_divisors(X) == N end, lists:seq(K,K+N-1)) of
                true ->
                    K;
                false ->
                    search_n_prime_divisor_numbers(N,K+1)
            end;
        _ ->
            search_n_prime_divisor_numbers(N, K+1)
    end.

number_of_prime_divisors(N) ->
    length(lists:filter(fun euler_helper:prime/1, euler_helper:divisors(N))).

%tests

search_n_prime_divisor_numbers_test_() ->
    [
     ?_assertEqual(14, search_n_prime_divisor_numbers(2)),
     ?_assertEqual(644, search_n_prime_divisor_numbers(3))
    ].

number_of_prime_divisors_test_() ->
    [
     ?_assertEqual(2, number_of_prime_divisors(14)),
     ?_assertEqual(2, number_of_prime_divisors(15)),
     ?_assertEqual(3, number_of_prime_divisors(644)),
     ?_assertEqual(3, number_of_prime_divisors(645)),
     ?_assertEqual(3, number_of_prime_divisors(646))
    ].
