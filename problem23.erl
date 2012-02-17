-module(problem23).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[sdivisors/1]).
-export([problem23/0]).


abundant(N) ->
    sdivisors(N) > N.

abundant_numbers_upto(N) ->
    lists:reverse(abundant_numbers_upto_(N)).

abundant_numbers_upto_(1) ->
    [];
abundant_numbers_upto_(N) ->
    Abundant = abundant(N),
    if
        Abundant ->
            [N];
        true ->
            []
    end ++ abundant_numbers_upto_(N-1).

sum_of_abundant(_,[],_) ->
    false;
sum_of_abundant(N,[H|_],_) when N/2 < H ->
    false;
sum_of_abundant(N,[H|T],Ablist) ->
    S = N - H,
    gb_sets:is_member(S,Ablist) orelse sum_of_abundant(N,T,Ablist).

sum_of_not_abundant_sums_upto(N) ->
    Ablist = abundant_numbers_upto(N),
    AbLookupList = gb_sets:from_list(Ablist),
    sum_of_not_abundant_sums_upto(N,Ablist,AbLookupList).

sum_of_not_abundant_sums_upto(1,_,_) ->
    1;
sum_of_not_abundant_sums_upto(N,Ablist,AbLookupList) ->
    IsAbundant = sum_of_abundant(N,Ablist,AbLookupList),
    if
        IsAbundant ->
            0;
        true ->
            N
    end + sum_of_not_abundant_sums_upto(N-1,Ablist,AbLookupList).

problem23() ->
    sum_of_not_abundant_sums_upto(28123).

%% tests

abundant_test_() ->
    [
     ?_assert(abundant(12)),
     ?_assertNot(abundant(6))
    ].

abundant_numbers_upto_test_() ->
    [
     ?_assertEqual([],abundant_numbers_upto(1)),
     ?_assertEqual([12,18,20],abundant_numbers_upto(21))
    ].

sum_of_abundant_test_() ->
    Ablist = abundant_numbers_upto(1024),
    AbLookupList = gb_sets:from_list(Ablist),
    [
     ?_assert(sum_of_abundant(24,Ablist,AbLookupList))
    ].

sum_of_not_abundant_sums_upto_test_() ->
    [
     ?_assertEqual(25+lists:sum(lists:seq(1,23)),sum_of_not_abundant_sums_upto(25))
    ].
