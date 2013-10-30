-module(problem32).
-include_lib("eunit/include/eunit.hrl").
-import(euler_helper,[int_to_digit_list/1,digit_list_to_int/1,perms/1]).
-export([problem32/0]).

problem32() ->
    pandigital_products().

is_pandigital(L) ->
    is_pandigital(L,1).

is_pandigital([],_) ->
    true;
is_pandigital(L,K) ->
    InList = lists:member(K,L),
    if
        InList ->
            NewL = lists:delete(K,L),
            is_pandigital(NewL,K+1);
        true ->
            false
    end.

pandigital_products() ->
    [ [digit_list_to_int(A),digit_list_to_int(B)] || [A,B] <- pandigital_products(1) ].

pandigital_products(N) when N < 10000 ->
    DList = int_to_digit_list(N),
    DListIsPanDigital = is_pandigital(DList),
    if
        DListIsPanDigital ->
            RestList = lists:seq(1,9) -- DList,
            IsSumProd = is_sum_prod(RestList,N),
            if
                IsSumProd ->
                    [N];
                true ->
                    []
            end;
        true ->
            []
    end ++ pandigital_products(N+1);
pandigital_products(N) when N >= 10000 ->
    [].

is_sum_prod(L,N) ->
    lists:any(fun([N1,N2]) -> digit_list_to_int(N1) * digit_list_to_int(N2) == N end, part_combs(L)).

part_combs([H|T]) ->
    part_combs([H],T).

part_combs(L,[A]) ->
    [[X,[A]] || X <- perms(L)];
part_combs([H1|T1],[H2|T2]) ->
    [[L1,L2] || D1 <- perms([H1|T1]), D2 <- perms([H2|T2]), E1 <- [H1|T1], E2 <- [H1,T1], L1 = D1 ++ ([E2] -- [E1]), L2 = (D2 ++ [E1]) -- [E2]]
        ++ part_combs([H1,H2|T1],T2).


%% tests

is_pandigital_test_() ->
    [
     ?_assert(is_pandigital([1])),
     ?_assertNot(is_pandigital([2,3]))
    ].

part_combs_test_() ->
    [
     ?_assertEqual([[[1],[2]]],part_combs([1,2])),
     ?_assertEqual([[[1],[2,3]],[[1],[3,2]],[[2],[1,3]],[[2],[3,1]],[[1,2],[3]],[[2,1],[3]]],
                   part_combs([1,2,3]))
    ].
