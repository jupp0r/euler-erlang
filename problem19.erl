-module(problem19).
-include_lib("eunit/include/eunit.hrl").
-export([problem19/0]).

get_days_from_till(X,X) ->
    [X];
get_days_from_till(From,Till) ->
    [From] ++ get_days_from_till(calendar:gregorian_days_to_date(calendar:date_to_gregorian_days(From) + 1), Till).

is_sunday_and_first_of_month({Year,Month,1}) ->
    7 == calendar:day_of_the_week({Year,Month,1});
is_sunday_and_first_of_month(_) ->
    false.

problem19() ->
    length(lists:filter(fun is_sunday_and_first_of_month/1, get_days_from_till({1901,1,1},{2000,12,31}))).

%% tests

weekday_test() ->
    ?assertEqual(1,calendar:day_of_the_week({1900,1,1})).

get_days_from_till_test_() ->
    [ ?_assertEqual([{1900,1,1}],get_days_from_till({1900,1,1},{1900,1,1})),
      ?_assertEqual([{1900,1,1},{1900,1,2}],get_days_from_till({1900,1,1},{1900,1,2})) ].

is_sunday_and_first_of_month_test_() ->
    [ ?_assert(is_sunday_and_first_of_month({2012,1,1})),
      ?_assertNot(is_sunday_and_first_of_month({2012,1,2})),
      ?_assertNot(is_sunday_and_first_of_month({2012,2,1})) ].
