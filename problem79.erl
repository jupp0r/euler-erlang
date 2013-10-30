-module(problem79).
-include_lib("eunit/include/eunit.hrl").
-export([problem79/0]).
-import(euler_helper,[int_to_digit_list/1]).
-import(lists,[map/2,member/2]).

problem79() ->
    Codes = [319, 680, 180, 690, 129, 620, 762, 689, 762, 318, 368, 710, 720, 710, 629, 168, 160, 689, 716, 731, 736, 729, 316, 729, 729, 710, 769, 290, 719, 680, 318, 389, 162, 289, 162, 718, 729, 319, 790, 680, 890, 362, 319, 760, 316, 729, 380, 319, 728, 716],
    find_code(Codes).

find_code(Codes) ->
    find_code(extract_constraints(Codes), Codes, []).
find_code(_, [], Result) ->
    Result;
find_code(Constraints,[Head|Rest], Results) ->
    find_code(Constraints, Rest, insert_code(Constraints, int_to_digit_list(Head), Results)).

insert_code(_,Code,[]) ->
    Code;
insert_code(_,[],Results) ->
    Results;
insert_code(Constraints, [CodeHead|CodeRest], [ResultHead|RestResults]) ->
    IsBefore = member([CodeHead, ResultHead], Constraints),
    IsAfter = member([ResultHead, CodeHead], Constraints), 
    IsIncluded = CodeHead == ResultHead,
    if
        IsIncluded ->
            insert_code(Constraints, CodeRest, [ResultHead|RestResults]);
        IsBefore ->
            [CodeHead, ResultHead] ++ insert_code(Constraints, CodeRest, RestResults);
        IsAfter ->
            [ResultHead, CodeHead] ++ insert_code(Constraints, CodeRest, RestResults);
        true ->
            [ResultHead] ++ insert_code(Constraints, [CodeHead|CodeRest], RestResults)
    end.

extract_constraints(Codes) ->
    extract_constraints(Codes, []).

extract_constraints([], ConstraintList) ->
    ConstraintList;
extract_constraints([Code|Rest], ConstraintList) ->
    extract_constraints(Rest, ConstraintList ++ extract_constraint(Code)).

extract_constraint(Number) ->
    List = int_to_digit_list(Number),
    [ [X,Y] || X <- List, Y <- List , pos(X,List) < pos(Y,List) ].

pos(_,[]) ->
    1000000;
pos(X,[X|_]) ->
    1;
pos(N1,[_|Rest]) ->
    1+pos(N1, Rest).

%% tests
extract_constraints_test_() ->
    [
     ?_assertEqual([[1,2],[1,3],[2,3]], extract_constraints([123]))
    ].

extract_constraint_test_() ->
    [
     ?_assertEqual([[1,2],[1,3],[2,3]], extract_constraint(123))
    ].

pos_test_() ->
    [
     ?_assertEqual(2,pos(5,[6,5,7]))
    ].
        
insert_code_test_() ->
    [
     ?_assertEqual([1,2,3], insert_code([],[1,2,3],[])),
     ?_assertEqual([1,2,3], insert_code([[1,2]],[1],[2,3])),
     ?_assertEqual([3,1,9,6,8,0], insert_code)
    ].
