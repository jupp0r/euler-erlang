-module(problem50).

-export([problem50/0]).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).


problem50() ->
    {_X,Length, Number} = longest_consecutive_prime_sum(999999),
    {Number, Length}.

consecutive_prime_sum(N, PrimeList, Min) ->
    consecutive_prime_sum(N, PrimeList, [], PrimeList, Min).

consecutive_prime_sum(_, [], _, _, _) ->
    notfound;
consecutive_prime_sum(N, [X|_], _, _, _) when N == X ->
    notfound;
consecutive_prime_sum(N, [H|T], Acc, PrimeList, Min) ->
    Sum = H + lists:sum(Acc),
    FirstPrime = case Acc of
                     [] -> 
                         N;
                     [FP|_] ->
                         FP
                 end,

    if
        Sum == N ->
            {FirstPrime, Acc ++ [H]};
        Sum > N ->
            [_H|ReducedPrimeList] = PrimeList,
            if
                FirstPrime >= Min ->
                   notfound;
                true ->
                    consecutive_prime_sum(N, ReducedPrimeList, [], ReducedPrimeList, Min)
                end;
        true ->
            consecutive_prime_sum(N, T, Acc ++ [H], PrimeList, Min)
    end.

find_consecutive_prime_sums(PrimeList) ->
    ReversedPrimes = lists:reverse(PrimeList),
    [RH|_] = ReversedPrimes,
    find_consecutive_prime_sums(ReversedPrimes, PrimeList, RH).
find_consecutive_prime_sums([], _, _) ->
    [];
find_consecutive_prime_sums([H|T], PrimeList, Min) ->
    io:fwrite("Prime sums for ~B~n",[H]),
    Sums = consecutive_prime_sum(H,PrimeList,Min),
    case Sums of
        {NewMin, NewSum} ->
            [NewSum] ++ find_consecutive_prime_sums(T, PrimeList, NewMin);
        notfound ->
            find_consecutive_prime_sums(T, PrimeList, Min)
    end.

longest_consecutive_prime_sum(N) ->
    PrimeList = euler_helper:calc_sieve(N),
    PrimeSums = find_consecutive_prime_sums(PrimeList),
    lists:foldl(fun(X,Acc) ->
                        Length = length(X),
                        {_, OldLength,_} = Acc,
                        if
                            Length > OldLength ->
                                {X, Length, lists:sum(X)};
                            true ->
                                Acc
                        end
                end, {[],0,0}, PrimeSums).

                                

% tests

consecutive_prime_sum_test_() ->
    PrimeList = euler_helper:calc_sieve(1000),
    [
     ?_assertEqual({2,[2,3,5,7,11,13]},consecutive_prime_sum(41, PrimeList,41)),
     ?_assertEqual(notfound,consecutive_prime_sum(43, PrimeList, 43))
    ].

longest_consecutive_prime_sum_test_() ->
     [
      {timeout, 200, ?_assertEqual({[2,3,5,7,11,13],6,41},longest_consecutive_prime_sum(100))}
     ].
