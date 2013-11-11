-module(problem35).

-include_lib("eunit/include/eunit.hrl").

-export([problem35/0]).

problem35() ->
    length(circular_primes_below(1000000)).

circular_primes_below(N) ->
    PrimeList = ordsets:to_list(euler_helper:calc_sieve(N)),
    find_circular_primes(PrimeList).

find_circular_primes(PrimeList) ->
    [X || X <- PrimeList,
          lists:all(fun(Y) -> lists:member(Y,PrimeList) end, circulars(X))
    ].
    
circulars(N) ->
    DigitList = euler_helper:int_to_digit_list(N),
    [euler_helper:digit_list_to_int(X) || X <- all_shift_lists(DigitList)].
    
all_shift_lists(L) ->
    all_shift_lists(L,length(L)).

all_shift_lists(_,0) ->
    [];
all_shift_lists(L,N) ->
    [L] ++ all_shift_lists(shift_list(L),N-1).

shift_list([H|T]) ->
    T ++ [H].

% tests

circular_primes_test_() ->
    [
     ?_assertEqual([2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97], circular_primes_below(100))
    ].

circulars_test_() ->
    [
     ?_assertEqual([123,231,312], circulars(123))
    ].

shift_list_test_() ->
    [
     ?_assertEqual([b,c,a],shift_list([a,b,c]))
    ].
