-module(problem42).
-include_lib("eunit/include/eunit.hrl").
-export([problem42/0]).

problem42() ->
    Triangles = lists:map(fun euler_helper:triangle_seq/1, lists:seq(1,26)),
    {ok, Binary} = file:read_file("problem42.txt"),
    TokenizedList =  string:tokens(binary:bin_to_list(Binary),","),
    StrippedList = lists:map(fun(X) ->
                                     string:strip(X,both,$")
                             end, TokenizedList),
    TriangleWords = [ X || X <- StrippedList,
                           L <- [word_to_digit_list(X)],
                           lists:member(lists:sum(L),Triangles)
                    ],
    length(TriangleWords).

word_to_digit_list(L) ->
    Difference = $S - 19,
    [X - Difference || X <- L].

%tests
word_to_digit_list_test_() ->
    [
     ?_assertEqual([19,11,25],word_to_digit_list("SKY"))
    ].
