-module(problem33).
-include_lib("eunit/include/eunit.hrl").
-export([problem33/0]).

problem33() ->
    Numbers = lists:seq(10,99),
    CanceledFractions =[{X,Y} || X <- Numbers,
              Y <- Numbers,
              X < Y,
              not_trivial(X,Y),
              same_cancelled(X,Y)
    ],
    {BigNumerator, BigDenominator} = lists:foldl(fun({X,Y}, {A,B}) ->
                                                         {X*A,Y*B}
                                                 end, {1,1}, CanceledFractions),
    GCD = euler_helper:gcd(BigNumerator, BigDenominator),
    Denominator = BigDenominator div GCD,
    Denominator.

not_trivial(X,Y) ->
    LastXDigit = lists:last(euler_helper:int_to_digit_list(X)),
    LastYDigit = lists:last(euler_helper:int_to_digit_list(Y)),
    LastXDigit /= 0 andalso LastYDigit /= 0.

same_cancelled(X,Y) ->
    XDigits = euler_helper:int_to_digit_list(X),
    YDigits = euler_helper:int_to_digit_list(Y),
    Candidates = [{A,B} || A <- XDigits,
                           B <- YDigits,
                           NA <- XDigits -- [A],
                           NB <- YDigits -- [B],
                           NA == NB,
                           A < B],
    lists:any(fun({A,B}) ->
                      B/A == Y/X
              end, Candidates).
                           

%tests

not_trivial_test_() ->
    [
     ?_assertNot(not_trivial(30,50)),
     ?_assert(not_trivial(49,98))
    ].

same_cancelled_test_() ->
    [
     ?_assert(same_cancelled(49,98)),
     ?_assertNot(same_cancelled(51,52))
    ].
