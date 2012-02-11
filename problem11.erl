-module(problem11).
-include_lib("eunit/include/eunit.hrl").
-export([problem11/0]).

-define(input_list,[
08, 02, 22, 97, 38, 15, 00, 40, 00, 75, 04, 05, 07, 78, 52, 12, 50, 77, 91, 08,
49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 04, 56, 62, 00,
81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 03, 49, 13, 36, 65,
52, 70, 95, 23, 04, 60, 11, 42, 69, 24, 68, 56, 01, 32, 56, 71, 37, 02, 36, 91,
22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80,
24, 47, 32, 60, 99, 03, 45, 02, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50,
32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70,
67, 26, 20, 68, 02, 62, 12, 20, 95, 63, 94, 39, 63, 08, 40, 91, 66, 49, 94, 21,
24, 55, 58, 05, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72,
21, 36, 23, 09, 75, 00, 76, 44, 20, 45, 35, 14, 00, 61, 33, 97, 34, 31, 33, 95,
78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 03, 80, 04, 62, 16, 14, 09, 53, 56, 92,
16, 39, 05, 42, 96, 35, 31, 47, 55, 58, 88, 24, 00, 17, 54, 24, 36, 29, 85, 57,
86, 56, 00, 48, 35, 71, 89, 07, 05, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58,
19, 80, 81, 68, 05, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 04, 89, 55, 40,
04, 52, 08, 83, 97, 35, 99, 16, 07, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66,
88, 36, 68, 87, 57, 62, 20, 72, 03, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69,
04, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 08, 46, 29, 32, 40, 62, 76, 36,
20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 04, 36, 16,
20, 73, 35, 29, 78, 31, 90, 01, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 05, 54,
01, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 01, 89, 19, 67, 48
]).

pos_to_tuple(Pos,XMax,YMax) when Pos =< XMax*YMax ->
    {((Pos - 1) rem XMax) + 1, ((Pos - 1) div YMax) + 1 }.

list_to_matrix(L,XMax, YMax) ->
    NumberedList = list_to_numbered_list(L),
    KeyValFun = fun({Key, Val}) ->
                        { pos_to_tuple(Key,XMax,YMax), Val } end,
    KeyValList = lists:map(KeyValFun, NumberedList),
    dict:from_list(KeyValList).

list_to_numbered_list(L) ->
    list_to_numbered_list(1,L).

list_to_numbered_list(_,[]) ->
    [];
list_to_numbered_list(K,[H|T]) ->
    [{K,H}] ++ list_to_numbered_list(K+1,T).

adjascent_coords({X,Y},Dir,XMax,YMax) when X > 0, Y > 0, X =< XMax, Y =< YMax ->
    case Dir of
        right when X + 3 =< XMax ->
            [{X,Y},{X+1,Y},{X+2,Y},{X+3,Y}];
        left when X - 3 > 0 ->
            [{X-3,Y},{X-2,Y},{X-1,Y},{X,Y}];
        up when Y-3 > 0->
            [{X,Y-3},{X,Y-2},{X,Y-1},{X,Y}];
        down when Y + 3 =< YMax ->
            [{X,Y},{X,Y+1},{X,Y+2},{X,Y+3}];
        down_right when X + 3 =< XMax, Y + 3 =< YMax ->
            [{X,Y},{X+1,Y+1},{X+2,Y+2},{X+3,Y+3}];
        down_left when X - 3 > 0, Y + 3 =< YMax ->
            [{X,Y},{X-1,Y+1},{X-2,Y+2},{X-3,Y+3}];
        up_right when X + 3 =< XMax, Y - 3 > 0 ->
            [{X+3,Y-3},{X+2,Y-2},{X+1,Y-1},{X,Y}];
        up_left when X - 3 > 0, Y - 3 > 0 ->
            [{X-3,Y-3},{X-2,Y-2},{X-1,Y-1},{X,Y}];
        _ ->
            []
    end;
adjascent_coords(_,_,_,_) ->
    [].

adjascent_prod(Coords, Direction, Matrix, XMax, YMax) ->
    lists:foldl(fun(Y, Prod) -> Prod * Y end, 1, lists:map(fun(X) -> dict:fetch(X,Matrix) end, adjascent_coords(Coords, Direction, XMax, YMax))).

all_adjascent_prod(Coords, Matrix, XMax, YMax) ->
    lists:map(fun(X) -> adjascent_prod(Coords,X,Matrix,XMax,YMax) end, [right, left, up, down, down_right, down_left, up_right, up_left]).

problem11() ->
    Matrix = list_to_matrix(?input_list,20,20),
    CoordList = lists:map(fun({Key,_}) -> Key end, dict:to_list(Matrix)),
    ProdList = lists:flatten(lists:map(fun(X) -> all_adjascent_prod(X,Matrix,20,20) end,CoordList)),
    lists:max(ProdList).

%% tests

adjascent_prod_test_() ->
    Matrix = list_to_matrix(?input_list,20,20),
    [ ?_assertEqual(1788696,adjascent_prod({9,7},down_right,Matrix,20,20)),
      ?_assertEqual(1,adjascent_prod({20,20},down_rigth,Matrix,20,20)) ].

adjascent_coords_test_() ->
    [ ?_assertEqual([{1,1},{2,1},{3,1},{4,1}],adjascent_coords({1,1},right,4,4)),
      ?_assertEqual([],adjascent_coords({2,1},right,4,4)),
      ?_assertEqual([{1,2},{2,2},{3,2},{4,2}],adjascent_coords({4,2},left,4,4)),
      ?_assertEqual([],adjascent_coords({3,2},left,4,4)),
      ?_assertEqual([{2,1},{2,2},{2,3},{2,4}],adjascent_coords({2,4},up,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},up,4,4)),
      ?_assertEqual([{2,1},{2,2},{2,3},{2,4}],adjascent_coords({2,1},down,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},down,4,4)),
      ?_assertEqual([{1,1},{2,2},{3,3},{4,4}],adjascent_coords({1,1},down_right,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},down_right,4,4)),
      ?_assertEqual([{4,1},{3,2},{2,3},{1,4}],adjascent_coords({4,1},down_left,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},down_left,4,4)),
      ?_assertEqual([{4,1},{3,2},{2,3},{1,4}],adjascent_coords({1,4},up_right,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},up_right,4,4)),
      ?_assertEqual([{1,1},{2,2},{3,3},{4,4}],adjascent_coords({4,4},up_left,4,4)),
      ?_assertEqual([],adjascent_coords({2,3},up_left,4,4))

    ].

list_to_matrix_empty_test() ->
    Dict = dict:new(),
    ?assertEqual(Dict,list_to_matrix([],1,1)).

list_to_matrix_single_list_test() ->
    Dict = dict:new(),
    TestDict = dict:store({1,1},1,Dict),
    ?assertEqual(TestDict,list_to_matrix([1],1,1)).

list_to_matrix_size_test() ->
    Matrix = list_to_matrix(lists:seq(1,400),20,20),
    ?assertEqual(400,dict:size(Matrix)).

list_to_matrix_misc_test_() ->
    Matrix = list_to_matrix(lists:seq(1,16),4,4),
    F = fun(X,Y) ->
                dict:fetch({X,Y},Matrix)
        end,
    [ ?_assertEqual(1,F(1,1)),
      ?_assertEqual(2,F(2,1)),
      ?_assertEqual(3,F(3,1)),
      ?_assertEqual(4,F(4,1)),
      ?_assertEqual(5,F(1,2)),
      ?_assertEqual(6,F(2,2)),
      ?_assertEqual(7,F(3,2)),
      ?_assertEqual(8,F(4,2)),
      ?_assertEqual(9,F(1,3)),
      ?_assertEqual(10,F(2,3)),
      ?_assertEqual(11,F(3,3)),
      ?_assertEqual(12,F(4,3)),
      ?_assertEqual(13,F(1,4)),
      ?_assertEqual(14,F(2,4)),
      ?_assertEqual(15,F(3,4)),
      ?_assertEqual(16,F(4,4))
    ].
    

list_to_matrix_complicated_test_() ->
    Dict = dict:new(),
    Dict2 = dict:store({1,1},1,Dict),
    Dict3 = dict:store({2,1},2,Dict2),
    Dict4 = dict:store({1,2},3,Dict3),
    Dict5 = dict:store({2,2},4,Dict4),
    Matrix = list_to_matrix([1,2,3,4],2,2),
    [ ?_assertEqual(Dict5,Matrix),
      ?_assertEqual(1,dict:fetch({1,1},Matrix)),
      ?_assertEqual(2,dict:fetch({2,1},Matrix)),
      ?_assertEqual(3,dict:fetch({1,2},Matrix)),
      ?_assertEqual(4,dict:fetch({2,2},Matrix)) ].
    

list_to_matrix_input_test_() ->
    Matrix = list_to_matrix(?input_list,20,20),
    [ ?_assertEqual(8,dict:fetch({1,1}, Matrix)),
      ?_assertEqual(49,dict:fetch({1,2}, Matrix)),
      ?_assertEqual(48,dict:fetch({20,20}, Matrix)) ].

pos_to_tuple_test_() ->
    [?_assertEqual({1,1},pos_to_tuple(1,20,20)),
     ?_assertEqual({20,1},pos_to_tuple(20,20,20)),
     ?_assertEqual({2,1},pos_to_tuple(2,20,20)),
     ?_assertEqual({3,1},pos_to_tuple(3,20,20)),
     ?_assertEqual({2,2},pos_to_tuple(22,20,20)),
     ?_assertEqual({1,2},pos_to_tuple(21,20,20)),
     ?_assertEqual({20,20},pos_to_tuple(400,20,20)),
     ?_assertEqual({2,3},pos_to_tuple(10,4,4)),
     ?_assertEqual({1,3},pos_to_tuple(9,4,4)) ].

list_to_numbered_list_test_() ->
    [?_assertEqual([], list_to_numbered_list([])),
     ?_assertEqual([{1,1}], list_to_numbered_list([1])),
     ?_assertEqual([{1,1},{2,4},{3,7}], list_to_numbered_list([1,4,7]))].

list_to_numbered_list_seq_test_() ->
    list_to_numbered_list_seq_gen(1,32).

list_to_numbered_list_seq_gen(From,To) ->
    SeqList = lists:seq(From, To),
    NumList = list_to_numbered_list(SeqList),
    Dict = dict:from_list(NumList),
    fun(MyDict, L)  ->
            Fun = fun(_,_,[]) ->
                        [];
                   (F,D,[H|T]) ->
                        [?_test(?assertEqual(H,dict:fetch(H,D))) | F(F,D,T)]
                  end,
            Fun(Fun, MyDict, L)
        end (Dict, SeqList).
            
