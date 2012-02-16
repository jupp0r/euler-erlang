-module(euler_helper).
-include_lib("eunit/include/eunit.hrl").
-export([prime/1,dividable_by/2,gcd/2,lcm/2,lcm_multiple/1, int_to_digit_list/1, int_pow/2, int_pow_fun/3, fac/1, triangle_seq/1]).

-define(LONG_TEST_PRIME, 1073807359).

prime(X) ->
    prime(1,X).

prime(_,1) -> false;
prime(1,X) -> prime(2,X);
prime(Y,X) ->
    NeedsTest = needs_prime_testing(Y,X),
    if
        NeedsTest ->
            not (dividable_by(X,Y)) andalso prime(Y+1,X);
        true ->
            true
    end.

dividable_by(N,K) ->
    N rem K =:= 0.

needs_prime_testing(Y,X) ->
    Y =< math:sqrt(X).

%% euclids algorithm
gcd(X,0) ->
    X;
gcd(X,Y) ->
    gcd(Y,X rem Y).

lcm(X,Y) ->
    (X * Y) div gcd(X,Y).

lcm_multiple([X,Y|[]]) ->
    lcm(X,Y);
lcm_multiple([X,Y|T]) ->
    lcm_multiple([lcm(X,Y)|T]).

int_to_digit_list(N) ->
    lists:map(fun(X) -> {K,_} = string:to_integer([X]), K end, integer_to_list(N)).

int_pow(0,_) ->
    0;
int_pow(_,0) ->
    1;
int_pow(B,E) ->
    int_pow(0,B,E).

int_pow(K,B,E) ->
    int_pow_fun(K,B,E,fun(X) -> X end).

int_pow_fun(B,E,F) ->
    int_pow_fun(0,B,E,F).

int_pow_fun(K,B,E,F) ->
    if
        K >= E ->
            F(1);
        true ->
            F(B * int_pow_fun(K+1,B,E,F))
    end.

fac(0) ->
    1;
fac(N) ->
    fac(1,N).

fac(K,N) ->
    if
        K  >= N + 1 ->
            1;
        true ->
            K * fac(K+1,N)
    end.

triangle_seq(N) when N > 0 ->
    lists:sum(lists:seq(1,N)).

%% tests

triangle_seq_test_() ->
    [?_assertEqual(1,triangle_seq(1)),
     ?_assertEqual(28,triangle_seq(7)),
     ?_assertError(function_clause,triangle_seq(0)),
     ?_assertError(function_clause,triangle_seq(-4))].

prime_test_() ->
    [ ?_assert(prime(2)),
      ?_assert(prime(3)),
      ?_assert(prime(5)),
      ?_assert(prime(7)),
      ?_assertNot(prime(1)),
      ?_assertNot(prime(4)),
      ?_assertNot(prime(6)),
      ?_assertNot(prime(9)) ].

prime_long_test() ->
    ?assert(prime(?LONG_TEST_PRIME)).

prime_long_neg_test() ->
    ?assertNot(prime(?LONG_TEST_PRIME+1)).

prime_it_test() ->
    ?assert(prime(1,7)).

prime_it_not_test() ->
    ?assertNot(prime(1,4)).

dividable_by_test() ->
    ?assert(dividable_by(12,3)).

dividable_by_not_test() ->
    ?assertNot(dividable_by(12,5)).

needs_prime_testing_test_() ->
    [ ?_assert(needs_prime_testing(2,9)),
      ?_assertNot(needs_prime_testing(7,42)) ].

gcd_test_() ->
    [ ?_assertEqual(gcd(1,0),1),
      ?_assertEqual(gcd(4,8),4),
      ?_assertEqual(gcd(54,24),6)].

lcm_test_() ->
    [ ?_assertEqual(lcm(21,6),42),
      ?_assertEqual(lcm(3,4),12) ].

lcm_multiple_test_() ->
    [ ?_assertEqual(lcm_multiple([21,6]),42),
      ?_assertEqual(lcm_multiple(lists:seq(1,10)),2520)].

int_to_digit_list_test_() ->
    [ ?_assertEqual([1,2],int_to_digit_list(12)),
      ?_assertEqual([1,4,5],int_to_digit_list(145)) ].

int_pow_test_() ->
    [ ?_assertEqual(1,int_pow(2,0)),
     ?_assertEqual(9,int_pow(3,2))].

int_pow_fun_test_() ->
    [ ?_assertEqual(0,int_pow_fun(32,2,fun(_) -> 0 end)) ].

fac_test_() ->
    [ ?_assertEqual(1,fac(0)),
      ?_assertEqual(1,fac(1)),
      ?_assertEqual(40320,fac(8))].
