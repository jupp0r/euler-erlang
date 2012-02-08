-module(problem1).
-include_lib("eunit/include/eunit.hrl").
-export([problem1/0]).

multiple_of_x(X,K) ->
    K rem X == 0.

select_multiple_of_x(L, Y) ->
    [X || X <- L, multiple_of_x(Y,X)].

sum_of_div_list(L, Y) ->
    Divlist = select_multiple_of_x(L,Y),
    lists:sum(Divlist).

sum_of_multiple_div_lists(P,V) ->
    lists:sum([X || X <- V, multiple_of_any(X,P)]).

problem1() ->
    sum_of_multiple_div_lists([3,5],lists:seq(1,999)).

multiple_of_any(_X, []) ->
    false;
multiple_of_any(X, [H|T]) ->
    multiple_of_x(H,X) or multiple_of_any(X,T).

%% tests

multiple_of_x_test() ->
    [
     ?assert(multiple_of_x(3,3)),
     ?assertNot(multiple_of_x(2,3)),
     ?assert(multiple_of_x(5,15)),
     ?assert(multiple_of_x(6,24)),
     ?assert(multiple_of_x(8,32)),
     ?assertNot(multiple_of_x(4,23))
    ].

select_multiple_of_x_single_test() ->
    ?assertEqual([3],select_multiple_of_x([1,2,3,4,5],3)).

select_multiple_of_x_multiple_test() ->
    ?assertEqual([6,12],select_multiple_of_x([1,2,3,5,6,8,9,12,13],6)).

sum_of_div_list_test() ->
    ?assertEqual(50,sum_of_div_list(lists:seq(1,20),5)).

sum_of_multiple_div_lists_example_web_test() ->
    ?assertEqual(23,sum_of_multiple_div_lists([3,5],lists:seq(1,9))).

sum_of_multiple_div_lists_dup_test() ->
    ?assertEqual(20,sum_of_multiple_div_lists([3,4],[8,12])).

multiple_of_any_test() ->
    ?assert(multiple_of_any(24,[11,12,7])).

multiple_of_any_neg_test() ->
    ?assertNot(multiple_of_any(24,[5,7,9])).


