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
    CountMap = euler_helper:count_map(Solutions),
    lists:foldl(fun({X,Count}, {P, Max}) ->
                        if
                            Count > Max ->
                                {X, Count};
                            true ->
                                {P, Max}
                        end
                end, {invalid, 0}, CountMap).


