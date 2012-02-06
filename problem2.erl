-module(problem2).
-include_lib("eunit/include/eunit.hrl").
-export([problem2/0]).

even(X) ->
    X rem 2 == 0.

fib(1) ->
    1;
fib(2) ->
    2;
fib(N) ->
    fib(N-2) + fib(N-1).

fibsum(Invariant, Termcond) ->
    fibsum(1, Invariant, Termcond).

fibsum(Y, Invariant, Termcond) ->
    X = fib(Y),
    case Termcond(X) of
        true ->
            case Invariant(X) of
                true ->
                    fib(Y) + fibsum(Y+1, Invariant, Termcond);
                false ->
                    fibsum(Y+1, Invariant, Termcond)
            end;
        false ->
            0
    end.

problem2() ->
    fibsum(fun even/1,fun(X) -> X < 4000000 end).

%% tests

even_test() ->
    ?assert(even(2)).

even_not_test() ->
    ?assertNot(even(1)).

fib_one_test() ->
    ?assertEqual(fib(1),1).

fib_two_test() ->
    ?assertEqual(fib(2),2).

fib_six_test() ->
    ?assertEqual(fib(6),13).

fibsum_simple_test() ->
    ?assertEqual(fibsum(fun(_) -> true end, fun(X) -> X < 4 end),6).

fibsum_longer_test() ->
    ?assertEqual(fibsum(1, fun(_) -> true end, fun(X) -> X < 6 end),11).

fibsum_step_test() ->
    ?assertEqual(fibsum(1,fun(_) -> true end, fun(X) -> X < 4 end), 6).

fibsum_invariant_test() ->
    ?assertEqual(fibsum(1,fun(X) -> X == 1 end, fun(X) -> X < 4 end), 1).
