-module(problem357).

-include_lib("eunit/include/eunit.hrl").

-export([problem357/0]).
-import(lists,[map/2,all/2]).

-compile([export_all]).

problem357() ->
    find_divisor_primes(100000000).

find_divisor_primes(N) ->
    io:fwrite("Creating Prime List...~n"),
    PrimeList = create_prime_list(N+1),
    io:fwrite("Finding Divisor Primes...~n"),
    find_divisor_primes(PrimeList, 0, PrimeList).

find_divisor_primes([], Sum, _) ->
    Sum;
find_divisor_primes([H|T], Sum, PrimeList) ->
    TestedNumber = H - 1,
    io:fwrite("Divisor Prime for ~B~n",[TestedNumber]),
    case divisorprime(TestedNumber, PrimeList) of
        true ->
            find_divisor_primes(T, Sum + TestedNumber, PrimeList);
        false ->
            find_divisor_primes(T, Sum, PrimeList)
    end.

divisorprime(N, PrimeList) ->
    DivisorList = divisors_prime(N,PrimeList),
    L = map(fun(X) -> X + N div X end, DivisorList),
    all(fun(X) -> lookup_prime(X,PrimeList) end, L).

lookup_prime(N, PrimeList) ->
    ordsets:is_element(N, PrimeList).

create_prime_list(N) ->
    euler_helper:calc_sieve(N).

divisors_prime(N, K) ->
    PrimeFactors = divisor_filter_list(N,divisors_prime2(N, K)),
    lists:sort(PrimeFactors ++ [X*Y || X <- PrimeFactors,
                                       Y <- PrimeFactors,
                                       X < Y,
                                       X*Y < N,
                                       X /= Y,
                                       not lists:member(X*Y,PrimeFactors),
                                       N rem (X*Y) == 0]).

divisors_prime2(N, []) ->
    [1,N];
divisors_prime2(N, [H|T]) ->
    exponent_factors(N,H) ++ divisors_prime(N,T).
                                 
exponent_factors(N,K) ->
    exponent_factors(N,K,1).

exponent_factors(N,K,X) ->
    TestNumber = euler_helper:int_pow(K,X),
    IsEnough = TestNumber >= N,
    if not IsEnough ->
            [TestNumber] ++ exponent_factors(N, K, X+1);
       true ->
            []
    end.

divisor_filter_list(N,L) ->
    lists:filter(fun(X) -> N rem X == 0 end, L).
                        

%tests
iterate_last_digits_test_() ->
    [
     ?_assertEqual(true , divisorprime(30, create_prime_list(100)))
    ].

divisors_prime_test_() ->
    PrimeList=[2,3,5,7,11],
    [
     ?_assertEqual([1,2], divisors_prime(2, PrimeList)),
     ?_assertEqual([1,2,4], divisors_prime(4, PrimeList)),
     ?_assertEqual([1,3,9,27,81], divisors_prime(81, PrimeList)),
     ?_assertEqual(euler_helper:divisors(14253),divisors_prime(14253,calc_sieve(14253))),
     ?_assertEqual(euler_helper:divisors(23128),divisors_prime(23128,calc_sieve(23128)))
    ].

exponent_factors_test_() ->
    [
     ?_assertEqual([2,4,8], exponent_factors(12, 2)),
     ?_assertEqual([2,4], exponent_factors(8, 2))
    ].

divisor_filter_list_test_() ->
    [
     ?_assertEqual(euler_helper:divisors(14253),divisor_filter_list(14253,lists:seq(1,14253)))
    ].    
