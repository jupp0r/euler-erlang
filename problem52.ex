ExUnit.start

defmodule Problem52 do
  use ExUnit.Case

  def problem52 do
    search_list = :lists.seq(10,10000000)
    Enum.find(search_list, fn(x) ->
                               digits = :euler_helper.int_to_digit_list(x)
                               perms = :euler_helper.perms(digits)
                               test_nums = lc factor inlist :lists.seq(2,6), y inlist [factor * x] do
                                 :euler_helper.int_to_digit_list(y)
                               end
                               Enum.all?(test_nums, fn(x) -> Enum.member?(perms,x) end)
                           end)
  end
end
