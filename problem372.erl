-module(problem372).
-export([problem372/0]).
-import(euler_helper,[int_pow/2]).

problem372() ->
    length([{X,Y} || Domain = lists:seq(2*int_pow(10,6)+1,int_pow(10,9)), X <- Domain, Y <- Domain, 0 == ((Y*Y) div (X*X)) rem 2]).
