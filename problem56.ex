ExUnit.start

defmodule Problem56 do
  use ExUnit.Case

  def problem56 do
    :lists.max(lc a inlist :lists.seq(1,99), b inlist :lists.seq(1,99) do
                 :lists.sum(:euler_helper.int_to_digit_list(:euler_helper.int_pow(a,b)))
               end)
  end
end
