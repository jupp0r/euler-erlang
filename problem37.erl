-module(problem37).
-include_lib("eunit/include/eunit.hrl").

-export([problem37/0]).

problem37() ->
    FastLookupPrimes = euler_helper:calc_sieve(1000000),
    Primes = ordsets:to_list(FastLookupPrimes),
    FilteredPrimes = lists:filter(fun(X) ->
                                          not lists:member(0,euler_helper:int_to_digit_list(X)) end, Primes),
    lists:sum([X || X <- FilteredPrimes,
          X > 7,
          truncatable(X,FastLookupPrimes)]).

take_left(N) ->
    take_left_digits(euler_helper:int_to_digit_list(N)).

take_left_digits([_]) ->
    [];
take_left_digits([_|T]) ->
    [euler_helper:digit_list_to_int(T)] ++ take_left_digits(T).

take_right(N) ->
    ReversedResults = take_left_digits(lists:reverse(euler_helper:int_to_digit_list(N))),
    [euler_helper:digit_list_to_int(lists:reverse(euler_helper:int_to_digit_list(X))) || X <- ReversedResults].
    
truncatable(N, PrimeList) ->
    lists:all(fun(Y) -> ordsets:is_element(Y,PrimeList) end, take_left(N)) andalso
    lists:all(fun(Y) -> ordsets:is_element(Y,PrimeList) end, take_right(N)).

% tests
take_left_test_() ->
    [
     ?_assertEqual([123,23,3], take_left(3123))
    ].

take_right_test_() ->
    [
     ?_assertEqual([312,31,3], take_right(3123))
    ].
