-module(problem43).
-include_lib("eunit/include/eunit.hrl").
-export([problem43/0]).

problem43() ->
    Permutations = euler_helper:perms(lists:seq(0,9)),
    SubstringPermutations = [euler_helper:digit_list_to_int(X) || X <- Permutations,
                                  euler_helper:digit_list_to_int(lists:sublist(X,2,3)) rem 2 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,3,3)) rem 3 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,4,3)) rem 5 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,5,3)) rem 7 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,6,3)) rem 11 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,7,3)) rem 13 ==0,
                                  euler_helper:digit_list_to_int(lists:sublist(X,8,3)) rem 17 ==0],
    lists:sum(SubstringPermutations).

