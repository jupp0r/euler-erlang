-module(problem41).

-export([problem41/0]).
-include_lib("eunit/include/eunit.hrl").

problem41() ->
    PrimeCandidates = [euler_helper:digit_list_to_int(X) || X <- empty_perms(lists:seq(1,9)), euler_helper:is_pandigital(X)],
    PrimeCandidates2 = lists:filter(fun(X) -> X rem 2 /= 0 andalso X rem 3 /= 0 end, PrimeCandidates),
    io:fwrite("Filtering for Primes~n"),
    lists:max(lists:filter(fun euler_helper:prime/1, PrimeCandidates2)).

empty_perms([]) ->
    [[]];
empty_perms(UnsortedList) ->
    List = lists:usort(UnsortedList),
    lists:usort(euler_helper:perms(List) ++ lists:merge([empty_perms(List -- [X]) || X <- List])) -- [[]].

% tests

empty_perms_test_() ->
    [
     ?_assertEqual(lists:usort([[1,2],[2,1],[1],[2]]), empty_perms([1,2])),
     ?_assertEqual(lists:usort([[a,b,c],[b,c,a],[c,b,a],[a,c,b],[b,a,c],[c,a,b],[a,b],[b,a],[a,c],[c,a],[b,c],[c,b],[a],[b],[c]]), empty_perms([a,b,c]))
    ].
