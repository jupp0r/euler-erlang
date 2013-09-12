-module(problem97).
-include_lib("eunit/include/eunit.hrl").
-export([problem97/0]).
-import(euler_helper,[int_pow/2]).


iterate_last_digits(Number,_ ,0 , _) ->
    Number;
iterate_last_digits(Number, Base, Exp, Digits) ->
    iterate_last_digits((Base * Number) rem int_pow(10, Digits), Base, Exp - 1, Digits).

problem97() ->
    (28433*iterate_last_digits(1,2,7830457,10)+1) rem int_pow(10,10).

%% tests
iterate_last_digits_test_() ->
    [
     ?_assertEqual(4,iterate_last_digits(1,2,2,1)),
     ?_assertEqual(24,iterate_last_digits(1,2,10,3))
    ].
