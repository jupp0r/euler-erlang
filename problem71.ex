ExUnit.start

require Integer
import Euler

defmodule Problem71 do
  use ExUnit.Case

  def problem71 do
    fractions = set_of_reduced_proper_fractions(1000000)
    index = Enum.find_index(fractions, &(&1 == {3,7}))
    IO.puts inspect(Enum.at(fractions, index-1))
  end

  defp set_of_reduced_proper_fractions n do
    set_of_reduced_proper_fractions_(n) |>
    Enum.sort_by(fn {a,b} -> a/b end)
  end
  defp set_of_reduced_proper_fractions_ 1 do
    []
  end
  defp set_of_reduced_proper_fractions_ n do
  ((Float.floor(3/7*n) |> round)..(Float.ceil(3/7*n) |> round) |>
    Enum.filter(&(:euler_helper.gcd(&1,n) == 1)) |>
    Enum.map(&({&1,n})))
  ++ set_of_reduced_proper_fractions_(n-1)
  end
end
