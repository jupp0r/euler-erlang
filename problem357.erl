-module(problem357).

-include_lib("eunit/include/eunit.hrl").

-export([problem357/0]).
-import(lists,[map/2,all/2]).

-compile([export_all]).

problem357() ->
    find_divisor_primes(100000000).

find_divisor_primes(N) ->
    io:fwrite("Creating Prime List...~n"),
    PrimeList = create_prime_list(2*N),
    io:fwrite("Finding Divisor Primes...~n"),
    find_divisor_primes(N,0, PrimeList).

find_divisor_primes(0, Sum, _) ->
    Sum;
find_divisor_primes(N, Sum, PrimeList) ->
    case divisorprime(N, PrimeList) of
        true ->
            find_divisor_primes(N-1, Sum + N, PrimeList);
        false ->
            find_divisor_primes(N-1, Sum, PrimeList)
    end.

divisorprime(N, PrimeList) ->
    DivisorList = euler_helper:divisors(N),
    L = map(fun(X) -> X + N div X end, DivisorList),
    all(fun(X) -> lookup_prime(X,PrimeList) end, L).

lookup_prime(N, PrimeList) ->
    gb_sets:is_element(N, PrimeList).

create_prime_list(N) ->
    calc_sieve(N).

sieve(Candidates,Primes,Iterator) ->
    SetEmpty = gb_sets:is_empty(Candidates),
    if
        SetEmpty == true ->
            Primes;
        Iterator == none ->
            Primes;
        true ->
            {H, NextIterator} = gb_sets:next(Iterator),
            ReducedList = remove_multiples_of(H, gb_sets:del_element(H, Candidates)),
            NewPrimes = gb_sets:add_element(H,Primes),
            sieve(ReducedList, NewPrimes , NextIterator)
    end.

remove_multiples_of(N,L) ->
    io:fwrite("removing multiples of ~B~n",[N]),
    remove_multiples_of(N,L,gb_sets:iterator(L)).

remove_multiples_of(Number,Candidates,Iterator) ->
    Next = gb_sets:next(Iterator),
    case Next of
        none ->
            Candidates;
        {Elem, NextIterator} ->
            if
                Elem rem Number == 0 ->
                    remove_multiples_of(Number,gb_sets:del_element(Elem,Candidates),NextIterator);
                true ->
                    remove_multiples_of(Number,Candidates,NextIterator)
            end
    end.

calc_sieve(N) ->
    io:fwrite("Creating Candidates...~n"),
    Candidates=gb_sets:from_list(lists:seq(3,N,2)),
    io:fwrite("Sieving...~n"),
    gb_sets:add_element(2,sieve(Candidates,gb_sets:new(),gb_sets:iterator(Candidates))).


%tests
iterate_last_digits_test_() ->
    [
     ?_assertEqual(true , divisorprime(30, create_prime_list(100)))
    ].

calc_sieve_test_() ->
    [
     ?_assertEqual([2,3,5,7], gb_sets:to_list(calc_sieve(10)))
    ].
remove_multiples_of_test_() ->
    [
     ?_assertEqual([],gb_sets:to_list(remove_multiples_of(2,gb_sets:new()))),
     ?_assertEqual([3,5,7,9], gb_sets:to_list(remove_multiples_of(2,gb_sets:from_list(lists:seq(3,10))))),
     ?_assertEqual([4,5,7,8,10], gb_sets:to_list(remove_multiples_of(3,gb_sets:from_list(lists:seq(3,10)))))
    ].
