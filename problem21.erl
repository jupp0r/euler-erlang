-module(problem21).
-include_lib("eunit/include/eunit.hrl").
-export([problem21/0]).

divisors(0) ->
    [];
divisors(1) ->
    [];
divisors(N) ->
    lists:sort(divisors(1,N)).

divisors(1,N) ->
    [1] ++ divisors(2,N);
divisors(K,N) ->
    Enough = K > math:sqrt(N),
    if
        Enough ->
            [];
        true ->
            if
                N rem K == 0 ->
                    [K, N div K];
                true ->
                    []
            end ++ divisors(K+1,N)
    end.

sdivisors(N) ->
    lists:sum(divisors(N)).

amicable_number_sum_upto(1) ->
    0;
amicable_number_sum_upto(N) ->
    IsA = amicable_number(N),
    if
        IsA ->
            N;
        true ->
            0
    end + amicable_number_sum_upto(N-1).
    
problem21() ->
    amicable_number_sum_upto(9999).

amicable_number(N) ->
    NDiv = sdivisors(N),
    SDiv = sdivisors(NDiv),
    SDiv == N andalso N /= NDiv.

%% tests

divisors_test_() ->
    [
     ?_assertEqual([],divisors(0)),
     ?_assertEqual([],divisors(1)),
     ?_assertEqual([1],divisors(2)),
     ?_assertEqual([1,2,3],divisors(6)),
     ?_assertEqual([1,2,3,4,6],divisors(12))
    ].

amicable_number_test_() ->
    [
     ?_assert(amicable_number(220)),
     ?_assert(amicable_number(284)),
     ?_assertNot(amicable_number(221)),
     ?_assert(amicable_number(1184)),
     ?_assert(amicable_number(1210)),
     ?_assertNot(amicable_number(6))
    ].

amicable_number_sum_upto_test_() ->
    [
     ?_assertEqual(220+284,amicable_number_sum_upto(300)),
     ?_assertEqual(0,amicable_number_sum_upto(6))
    ].
