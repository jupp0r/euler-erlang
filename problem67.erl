-module(problem67).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[triangle_seq/1,longest_path/2,read_triangular_graph_data/1]).
-export([problem67/0]).

problem67() ->
    G = read_triangular_graph_data("problem67.txt"),
    longest_path(G,1).
