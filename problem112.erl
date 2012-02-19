-module(problem112).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_to_digit_list/1]).
-export([problem112/0]).

is_increasing(N) ->
    is_increasing_(int_to_digit_list(N)).

is_increasing_([]) ->
    true;
is_increasing_([_]) ->
    true;
is_increasing_([H1,H2|T]) ->
    H2 >= H1 andalso is_increasing_([H2|T]).

is_decreasing(N) ->
    is_decreasing_(int_to_digit_list(N)).

is_decreasing_([]) ->
    true;
is_decreasing_([_]) ->
    true;
is_decreasing_([H1,H2|T]) ->
    H2 =< H1 andalso is_decreasing_([H2|T]).

is_bouncy(N) ->
    not is_increasing(N) andalso not is_decreasing(N).

bouncy_ratio_search(R) ->
    bouncy_ratio_search(0,99,R).

bouncy_ratio_search(BCount,N,R) when ((BCount)/(N-1)) >= R ->
    N-1;
bouncy_ratio_search(BCount,N,R) ->
    IsBouncy = is_bouncy(N),
    NewBCount = if
                    IsBouncy ->
                        BCount + 1;
                    true ->
                        BCount
                end,
    bouncy_ratio_search(NewBCount,N+1,R).
        
problem112() ->
    bouncy_ratio_search(0.99).


%% tests

is_increasing_test_() ->
    [
     ?_assert(is_increasing(1)),
     ?_assert(is_increasing(23459)),
     ?_assertNot(is_increasing(54))
    ].

is_decreasing_test_() ->
    [
     ?_assert(is_decreasing(1)),
     ?_assertNot(is_decreasing(34)),
     ?_assert(is_decreasing(85431))
    ].

is_bouncy_test_() ->
    [
     ?_assert(is_bouncy(1232)),
     ?_assertNot(is_bouncy(1)),
     ?_assertNot(is_bouncy(25)),
     ?_assertNot(is_bouncy(52)),
     ?_assertNot(is_bouncy(1234)),
     ?_assertNot(is_bouncy(111)),
     ?_assert(is_bouncy(101))
    ].

bouncy_ratio_search_test_() ->
    [
     ?_assertEqual(538,bouncy_ratio_search(0.5)),
     ?_assertEqual(21780,bouncy_ratio_search(0.9))
    ].
