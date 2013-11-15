-module(problem40).
-include_lib("eunit/include/eunit.hrl").
-export([problem40/0]).

problem40() ->
    Numbers = lists:seq(1,1000000),
    Search = [1,10,100,1000,10000,100000,1000000],
    {_,_,Res} = lists:foldl(fun(X,{L, Counter, Results}) -> 
                                    case L of
                                        [] ->
                                            {L, Counter, Results};
                                        [RestSearch|T] ->
                                            Digits = euler_helper:int_to_digit_list(X),
                                            Length = length(Digits),
                                            if
                                                Counter =< RestSearch andalso RestSearch < Counter + Length ->
                                                    {T, Counter + Length, Results ++ [lists:nth(RestSearch - Counter + 1, Digits)]};
                                                true ->
                                                    {[RestSearch|T], Counter + Length, Results}
                                            end
                                    end
                            end, {Search, 1, []}, Numbers),
    lists:foldl(fun(X,Acc) ->
                        Acc * X end, 1, Res).


