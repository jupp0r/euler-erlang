-module(problem17).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_to_digit_list/1]).

-export([problem17/0]).

last_digit_letter_count(0) ->
    0;
last_digit_letter_count(1) ->
    3;
last_digit_letter_count(2) ->
    3;
last_digit_letter_count(3) ->
    5;
last_digit_letter_count(4) ->
    4;
last_digit_letter_count(5) ->
    4;
last_digit_letter_count(6) ->
    3;
last_digit_letter_count(7) ->
    5;
last_digit_letter_count(8) ->
    5;
last_digit_letter_count(9) ->
    4.

second_digit_letter_count(4) ->
    5;
second_digit_letter_count(5) ->
    5;
second_digit_letter_count(6) ->
    5;
second_digit_letter_count(7) ->
    7;
second_digit_letter_count(_) ->
    6.

ten_letter_count(N) when N >= 0, N =< 9 ->
    last_digit_letter_count(N);
ten_letter_count(10) ->
    3;
ten_letter_count(11) ->
    6;
ten_letter_count(12) ->
    6;
ten_letter_count(13) ->
    8;
ten_letter_count(15) ->
    7;
ten_letter_count(18) ->
    8;
ten_letter_count(N) when N >= 10, N =< 19 ->
    [_,H] = int_to_digit_list(N),
    last_digit_letter_count(H) + 4;
ten_letter_count(N) when N >= 20, N =< 99 ->
    [F,L] = int_to_digit_list(N),
    second_digit_letter_count(F) + last_digit_letter_count(L).

hundred_letter_count(N) when N >= 100, N =< 999, N rem 100 == 0 ->
    [F,_,_] = int_to_digit_list(N),
    last_digit_letter_count(F) + 7;
hundred_letter_count(N) when N >= 100, N =< 999 ->
    [F,S,T] = int_to_digit_list(N),
    last_digit_letter_count(F) + 10 + ten_letter_count(10*S+T).

letter_count(1000) -> 11;
letter_count(N) when N >= 1, N =< 9 ->
    last_digit_letter_count(N);
letter_count(N) when N >= 10, N =< 99 ->
    ten_letter_count(N);
letter_count(N) when N >= 100, N =< 999 ->
    hundred_letter_count(N).

problem17() ->
    lists:sum(lists:map(fun letter_count/1, lists:seq(1,1000))).

%% tests

last_digit_letter_count_test_() ->
    [?_assertEqual(3,last_digit_letter_count(1)),
     ?_assertEqual(4, last_digit_letter_count(5)),
     ?_assertEqual(4,last_digit_letter_count(9))].

ten_letter_count_test_() ->
    [?_assertEqual(3,ten_letter_count(10)),
     ?_assertEqual(6,ten_letter_count(11)),
     ?_assertEqual(6,ten_letter_count(12)),
     ?_assertEqual(8,ten_letter_count(13)),
     ?_assertEqual(7,ten_letter_count(15)),
     ?_assertEqual(7,ten_letter_count(16)),
     ?_assertEqual(8,ten_letter_count(19)),
     ?_assertEqual(6,ten_letter_count(20)),
     ?_assertEqual(10,ten_letter_count(95))
    ].

second_digit_letter_count_test_() ->
    [?_assertEqual(6,second_digit_letter_count(2)),
     ?_assertEqual(6,second_digit_letter_count(3)),
     ?_assertEqual(5,second_digit_letter_count(4)),
     ?_assertEqual(5,second_digit_letter_count(5)),
     ?_assertEqual(5,second_digit_letter_count(6)),
     ?_assertEqual(7,second_digit_letter_count(7)),
     ?_assertEqual(6,second_digit_letter_count(8)),
     ?_assertEqual(6,second_digit_letter_count(9))
    ].

hundred_letter_count_test_() ->
    [?_assertEqual(23,hundred_letter_count(342)),
     ?_assertEqual(20,hundred_letter_count(115))].

letter_count_test_() ->
    [?_assertEqual(5,letter_count(8)),
     ?_assertEqual(3,letter_count(1)),
     ?_assertEqual(5,letter_count(40)),
     ?_assertEqual(10,letter_count(68)),
     ?_assertEqual(16,letter_count(101)),
     ?_assertEqual(10,letter_count(100)),
     ?_assertEqual(10,letter_count(200)),
     ?_assertEqual(22,letter_count(264)),
     ?_assertEqual(24,letter_count(896)),
     ?_assertEqual(11,letter_count(900)),
     ?_assertEqual(17,letter_count(910)),
     ?_assertEqual(20,letter_count(911)),
     ?_assertEqual(20,letter_count(990)),
     ?_assertEqual(24,letter_count(999)),
     ?_assertEqual(11,letter_count(1000))].
