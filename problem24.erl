-module(problem24).
-include_lib("eunit/include/eunit.hrl").
-export([problem24/0]).
-import(euler_helper,[perms/1]).

problem24() ->
    Perms = perms([0,1,2,3,4,5,6,7,8,9]),
    lists:nth(1000000,Perms).
