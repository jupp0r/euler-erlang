-module(problem15).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[fac/1]).
-export([problem15/0]).

count_routes(N) ->
    fac(2*N) div (fac(N)*fac(N)).
              
problem15() ->
    count_routes(20).

%% tests

count_routes_test_() ->
    [?_assertEqual(6,count_routes(2)),
     ?_assertEqual(2,count_routes(1))].
        
