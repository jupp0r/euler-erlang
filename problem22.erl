-module(problem22).
-include_lib("eunit/include/eunit.hrl").
-export([problem22/0]).

problem22() ->
    {ok,[Names]} = file:consult("problem22.txt"),
    SortedNames = lists:sort(Names),
    Letters = [[X - 64 || X <- Name] || Name <- SortedNames],
    NumberedLetters = lists:reverse(lists:foldl(
                       fun (X,[{Y,Acc}|T]) ->
                               [{X,Acc+1},{Y,Acc}|T];
                           (X,[]) ->
                               [{X,1}]
                       end,[], Letters)),
    Scores = [{List, Num, lists:sum(List) * Num} || {List,Num} <- NumberedLetters ],
    lists:foldl(fun ({_,_,Score},Acc) -> Acc + Score end, 0, Scores).
