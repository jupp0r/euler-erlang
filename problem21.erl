-module(problem21).
-include_lib("eunit/include/eunit.hrl").
-export([problem21/0]).
-import(euler_helper,[sdivisors/1]).

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
