-module(problem32).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_to_digit_list/1,digit_list_to_int/1,perms/1,is_pandigital/1]).
-export([problem32/0]).

problem32() ->
    Permutations = euler_helper:perms(lists:seq(1,9)),
    PermutationCombos = lists:map(fun(X) -> lists:map(fun euler_helper:digit_list_to_int/1, X) end, permutation_combos(Permutations)),
    lists:sum(lists:usort(lists:map(fun([_,_,C]) -> C end, lists:filter(fun([A,B,C]) -> A*B==C end, PermutationCombos)))).

permutation_combos([]) ->
    [];
permutation_combos([H|T]) ->
    [[A,B,C] || N1 <- lists:seq(1,length(H)-2),
                N2 <- lists:seq(N1+1,length(H)-1),
                A <- [lists:sublist(H,1,N1)],
                B <- [lists:sublist(H,N1+1,N2-N1)],
                C <- [lists:sublist(H,N2+1,length(H)-N2)]] ++ permutation_combos(T).

%tests
permutation_combos_test_() ->
    [
     ?_assertEqual(lists:sort([[[1],[2],[3]]]), lists:sort(permutation_combos([[1,2,3]]))),
     ?_assertEqual(lists:sort([[[1,2],[3],[4]],[[1],[2,3],[4]],[[1],[2],[3,4]]]), lists:sort(permutation_combos([[1,2,3,4]])))
    ].
