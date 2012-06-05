-module(problem12).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[triangle_seq/1]).

-export([problem12/0]).

num_divisors(1) ->
    1;
num_divisors(N) ->
    num_divisors(1,N).

num_divisors(K,N) ->
    Root = math:sqrt(N),
    SizeTest = K > Root,
    if
        SizeTest ->
            0;
        true ->
            if
                Root == K ->
                    1;
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

num_divisors_test_() ->
    [?_assertEqual(1,num_divisors(1)),
     ?_assertEqual(4,num_divisors(21)),
     ?_assertEqual(3,num_divisors(25))].

find_first_triangle_number_with_n_divisors_test_() ->
    [?_assertEqual(28,find_first_triangle_number_with_n_divisors(6))].
