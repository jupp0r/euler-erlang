-module(problem31).
-include_lib("eunit/include/eunit.hrl").
-export([problem31/0]).

spend_money(Target, Options) ->
    spend_money(Target,0,[],Options).

spend_money(_,_,_,[]) ->
    [];
spend_money(Target, Spent, Solution, _) when Target == Spent ->
    [Solution];
spend_money(Target,Spent,_,_) when Spent > Target ->
    [];
spend_money(Target, Spent, Solution, Options) ->
    [HeadOption | RestOptions] = Options,
    spend_money(Target, HeadOption + Spent, [HeadOption|Solution], Options)
        ++ spend_money(Target,Spent,Solution,RestOptions).

problem31() ->
    length(spend_money(200,[1,2,5,10,20,50,100,200])).
