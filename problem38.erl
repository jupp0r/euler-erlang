-module(problem38).
-include_lib("eunit/include/eunit.hrl").

-export([problem38/0]).

problem38() ->
    PandigitalNumbers = [euler_helper:digit_list_to_int(X) || X <- euler_helper:perms(lists:seq(1,9))],
    lists:max(lists:filter(fun pandigital_multiple/1, PandigitalNumbers)).

pandigital_multiple(N) ->
    NList = euler_helper:int_to_digit_list(N),
    pandigital_multiple(NList, 1, 1, 1, hd(NList) ).

pandigital_multiple(_, 1, 1, Length, _) when Length >= 5 ->
    false;
pandigital_multiple(N, Step, Start, Length, TestNum) ->
    Test = euler_helper:digit_list_to_int(lists:sublist(N,Start,Length)),
    if
        Test == TestNum * Step ->
            if
                Start + Length -1 == length(N) ->
                    true;
                true ->
                    NextLength = length(euler_helper:int_to_digit_list(TestNum * (Step+1))),
                    pandigital_multiple(N, Step+1, Start + Length, NextLength, TestNum)
            end;
        true ->
            NextLength = length(euler_helper:int_to_digit_list(TestNum)) + 1, 
            pandigital_multiple(N,1,1,NextLength,euler_helper:digit_list_to_int(lists:sublist(N,NextLength)))
    end.

%tests

pandigital_multiple_test_()->
    [
     ?_assert(pandigital_multiple(192384576)),
     ?_assert(pandigital_multiple(918273645)),
     ?_assertNot(pandigital_multiple(981273654))
    ].
