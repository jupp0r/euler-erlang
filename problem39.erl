-module(problem39).
-include_lib("eunit/include/eunit.hrl").

-export([problem39/0]).

problem39() ->
    Solutions = [ P || A <- lists:seq(1,500),
                              B <- lists:seq(A,500),
                              C <- lists:seq(1,500),
                              P <- [A+B+C],
                              P < 1000,
                              C*C == A*A + B*B
                 ],
    CountMap = count_map(Solutions),
    lists:foldl(fun({X,Count}, {P, Max}) ->
                        if
                            Count > Max ->
                                {X, Count};
                            true ->
                                {P, Max}
                        end
                end, {invalid, 0}, CountMap).


count_element(Elem, List) ->
    length([ok || I <- List,
                  I == Elem]).

count_map(List) ->
    UniqueList = lists:usort(List),
    [{X,count_element(X,List)} || X <- UniqueList].

%tests
count_element_test_() ->
    [
     ?_assertEqual(2, count_element(a,[a,b,a]))
    ].

count_map_test_() ->
    [
     ?_assertEqual([{a,2},{b,1}],count_map([a,b,a]))
    ].
