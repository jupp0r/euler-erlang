-module(problem18).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[triangle_seq/1,longest_path/2,read_triangular_graph_data/1]).
-export([problem18/0]).

problem18() ->
    G = read_triangular_graph_data("problem18.txt"),
    longest_path(G,1).
