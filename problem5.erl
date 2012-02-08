-module(problem5).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[prime/1, dividable_by/2, lcm_multiple/1]).
-export([problem5/0]).

problem5() ->
    lcm_multiple(lists:seq(1,20)).
