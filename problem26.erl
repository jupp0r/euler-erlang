-module(problem26).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_pow/2, loop_len/1]).
-export([problem26/0]).

div_list(N) ->
    div_list(N,N).

div_list(N,K) ->
    integer_to_list(int_pow(10,2*K) div N).

div_len(N) ->
    {N,loop_len(div_list(N))}.

problem26() ->
    LenList = [div_len(X) || X <- lists:seq(2,999)],
    lists:foldr(
      fun ({X,XVal},{Max,MaxVal}) ->
              if
                  XVal > MaxVal ->
                      {X,XVal};
                  true -> {Max,MaxVal}
              end
      end,
      {error,0}, LenList).

%% tests

div_list_double_test_() ->
    [
     ?_assertEqual("50",div_list(2,1)),
     ?_assertEqual("33",div_list(3,1)),
     ?_assertEqual("3333",div_list(3,2)),
     ?_assertEqual("2500",div_list(4,2))
    ].

div_list_test_() ->
    [
     ?_assertEqual("5000",div_list(2)),
     ?_assertEqual("2000000000",div_list(5)),
     ?_assertEqual("333333",div_list(3))
    ].

div_len_test_() ->
    [
     ?_assertEqual({3,1},div_len(3)),
     ?_assertEqual({7,6},div_len(7)),
     ?_assertEqual({6,1},div_len(6)),
     ?_assertEqual({37,3},div_len(37)),
     ?_assertEqual({185,3},div_len(185)),
     ?_assertEqual({11,2},div_len(11)),
     ?_assertEqual({81,9},div_len(81)),
     ?_assertEqual({17,16},div_len(17)),
     ?_assertEqual({19,18},div_len(19)),
     ?_assertEqual({29,28},div_len(29)),
     ?_assertEqual({97,96},div_len(97))
    ].
