-module(problem3).
-include_lib("eunit/include/eunit.hrl").
-export([problem3/0]).

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

prime_factors(X) ->
    lists:usort(prime_factors(1,X)).

prime_factors(_,1) -> [];
prime_factors(_,2) -> [];
prime_factors(1,X) -> prime_factors(2,X);
prime_factors(Y,X) ->
    NeedsTest = needs_factor_testing(Y,X),
    if
        NeedsTest ->
            YisPrime = prime(Y),
            YdivX = dividable_by(X,Y),
            if
                YisPrime and YdivX ->
                    DivProd = X div Y,
                    [Y] ++ cond_list(DivProd, prime(DivProd)) ++ prime_factors(Y+1,X);
                true ->
                    prime_factors(Y+1,X)
            end;
        true ->
            []
    end.

needs_prime_testing(Y,X) ->
    Y =< math:sqrt(X).

needs_factor_testing(2,4) ->
    true;
needs_factor_testing(Y,X) ->
    Y =< math:sqrt(X).

problem3() ->
    lists:max(prime_factors(600851475143)).

cond_list(X, Cond) ->
    case Cond of
        true ->
            [X];
        false ->
            []
    end.

%% tests

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

prime_factors_test_() ->
    [ ?_assertEqual(prime_factors(4),[2]),
      ?_assertEqual(prime_factors(6),[2,3]),
      ?_assertEqual(prime_factors(8),[2]),
      ?_assertEqual(prime_factors(7),[]),
      ?_assertEqual(prime_factors(12),[2,3]),
      ?_assertEqual(prime_factors(13195),[5,7,13,29]) ].

prime_factors_it_test_() ->
    [ ?_assertEqual(prime_factors(4),[2]),
      ?_assertEqual(prime_factors(21),[3,7]) ].

needs_prime_testing_test_() ->
    [ ?_assert(needs_prime_testing(2,9)),
      ?_assertNot(needs_prime_testing(7,42)) ].

needs_factor_testing_test_() ->
    [ ?_assertNot(needs_factor_testing(7,21)),
      ?_assert(needs_factor_testing(2,4)),
      ?_assertNot(needs_factor_testing(13,21)) ].

cond_list_test_() ->
    [ ?_assertEqual(cond_list(3,true),[3]) ].
