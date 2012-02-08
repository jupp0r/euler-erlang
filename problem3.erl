-module(problem3).
-include_lib("eunit/include/eunit.hrl").
-export([problem3/0]).
-import(euler_helper,[prime/1,dividable_by/2]).


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

prime_factors_test_() ->
    [ ?_assertEqual([2],prime_factors(4)),
      ?_assertEqual([2,3],prime_factors(6)),
      ?_assertEqual([2],prime_factors(8)),
      ?_assertEqual([],prime_factors(7)),
      ?_assertEqual([2,3],prime_factors(12)),
      ?_assertEqual([5,7,13,29],prime_factors(13195)) ].

prime_factors_it_test_() ->
    [ ?_assertEqual([2],prime_factors(4)),
      ?_assertEqual([3,7],prime_factors(21)) ].

needs_factor_testing_test_() ->
    [ ?_assertNot(needs_factor_testing(7,21)),
      ?_assert(needs_factor_testing(2,4)),
      ?_assertNot(needs_factor_testing(13,21)) ].

cond_list_test_() ->
    [ ?_assertEqual([3],cond_list(3,true)) ].
