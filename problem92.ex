ExUnit.start

require Integer
import Euler

defmodule Problem92 do
  use ExUnit.Case

  def problem92 do
    IO.puts(find_square_chains 1,1)
  end

  defp find_square_chains(n,_) when n > 9999999 do
    0
  end

  defp find_square_chains n,1 do
    find_square_chains n+1, n+1
  end

  defp find_square_chains n, 89 do
    1 + find_square_chains n+1, n+1
  end

  defp find_square_chains n, k do
    find_square_chains n, Enum.sum(Enum.map(:euler_helper.int_to_digit_list(k), &(&1*&1)))
  end
end
