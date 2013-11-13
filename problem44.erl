-module(problem44).

-include_lib("eunit/include/eunit.hrl").

-export([problem44/0]).

problem44() ->
    PentagonalList = generate_pentagonal_numbers(5000),
    PairList = [{X,Y} || X <- PentagonalList,
                         Y <- PentagonalList,
                         Y > X,
                         lists:member(Y-X, PentagonalList),
                         lists:member(X+Y, PentagonalList)],
    [{X,Y}|_] = lists:sort(fun({X1,Y1},{X2,Y2}) ->
                       Y1-X1 =< X2-Y2 end, PairList),
    Y-X.

                         
    

generate_pentagonal_numbers(Max) ->
    lists:map(fun(X) -> X*(3*X-1) div 2 end, lists:seq(1,Max)).

% tests

generate_pentagonal_numbers_test_()->
    [
     ?_assertEqual([1, 5, 12, 22, 35, 51, 70, 92, 117, 145], generate_pentagonal_numbers(10))
    ].

