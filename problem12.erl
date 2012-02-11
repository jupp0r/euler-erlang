-module(problem12).
-include_lib("eunit/include/eunit.hrl").

-export([problem12/0]).

triangle_seq(N) when N > 0 ->
    lists:sum(lists:seq(1,N)).

num_divisors(1) ->
    1;
num_divisors(N) ->
    num_divisors(1,N).

num_divisors(K,N) ->
    SizeTest = K > math:sqrt(N),
    if
        SizeTest ->
            0;
        true ->
            if
                N rem K == 0 ->
                    2;
                true ->
                    0
            end + num_divisors(K+1,N)
    end.

find_first_triangle_number_with_n_divisors(N) ->
    find_first_triangle_number_with_n_divisors(1,N).

find_first_triangle_number_with_n_divisors(K,N) ->
    TriangleNum = triangle_seq(K),
    NumDivs = num_divisors(TriangleNum),
    if
        NumDivs >= N ->
            TriangleNum;
        true ->
            find_first_triangle_number_with_n_divisors(K+1,N)
    end.

problem12() ->
    find_first_triangle_number_with_n_divisors(501).

%% tests
triangle_seq_test_() ->
    [?_assertEqual(1,triangle_seq(1)),
     ?_assertEqual(28,triangle_seq(7)),
     ?_assertError(function_clause,triangle_seq(0)),
     ?_assertError(function_clause,triangle_seq(-4))].

num_divisors_test_() ->
    [?_assertEqual(1,num_divisors(1)),
     ?_assertEqual(4,num_divisors(21))].

find_first_triangle_number_with_n_divisors_test_() ->
    [?_assertEqual(28,find_first_triangle_number_with_n_divisors(6))].
