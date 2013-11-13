-module(problem36).
-include_lib("eunit/include/eunit.hrl").

-export([problem36/0]).

problem36() ->
    BaseTenPalindromes = lists:filter(fun euler_helper:number_is_palindromic/1, lists:seq(1,1000000)),
    lists:sum(lists:filter(fun(X) ->
                                   BinString = hd(io_lib:format("~.2B",[X])),
                                   BinString == lists:reverse(BinString) 
                           end, BaseTenPalindromes)).
                                                  

% tests

