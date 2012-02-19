-module(problem27).
-export([problem27/0]).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[prime/1]).

problem27() ->
    List = [{num_quad_primes(A,B),A,B} || A <- lists:seq(-999,999), B <- lists:seq(-999,999), num_quad_primes(A,B) > 0],
    {FN, FA, FB} = lists:foldl(
      fun({N,A,B},{NMax,AMax,BMax}) ->
              if
                  N > NMax -> {N,A,B};
                  true ->
                      {NMax,AMax,BMax}
              end
      end,
                     {-1,error,error},
                     List),
    {FN,FA*FB}.

num_quad_primes(A,B) ->
    num_quad_primes(0,A,B).

num_quad_primes(N,A,B) ->
    IsPrime = prime(N*N + A*N +B),
    if
        IsPrime ->
            num_quad_primes(N+1,A,B);
        true ->
            N
    end.

%% tests

num_quad_primes_test_() ->
    [
     ?_assertEqual(40,num_quad_primes(1,41)),
     ?_assertEqual(80,num_quad_primes(-79,1601))
    ].
