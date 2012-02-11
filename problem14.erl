-module(problem14).
-include_lib("eunit/include/eunit.hrl").
-export([problem14/0]).

collatz(1) ->
    [1];
collatz(N) when (N rem 2) == 0 ->
    [N] ++ collatz(N div 2);
collatz(N) ->
    [N] ++ collatz(3*N + 1).

problem14() ->
    lists:foldl(
      fun({Xval, Xlen},{XMaxVal, XMaxLen}) ->
              if
                  Xlen > XMaxLen -> {Xval,Xlen};
                  true-> {XMaxVal, XMaxLen}
              end
      end,
      {0,0},
      lists:map(
        fun([X|T]) ->
                {X,length([X|T])}
        end,
        lists:map(
          fun collatz/1,
          lists:seq(1,999999)
         )
       )
     ).

%% tests

collatz_test_() ->
    [?_assertEqual([1],collatz(1)),
     ?_assertEqual([13,40,20,10,5,16,8,4,2,1], collatz(13)) ].
