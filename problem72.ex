ExUnit.start

require Integer

defmodule Problem72 do
  use ExUnit.Case
  def problem72 do
    number_of_proper_fractions_smaller_than(1000000) |>
    IO.puts
  end

  defp number_of_proper_fractions_smaller_than n do
    2..n |>
      Enum.map(&Euler.euler_phi/1) |>
      Enum.sum
  end

  test "number_of_proper_fractions_smaller_than" do
    assert number_of_proper_fractions_smaller_than(8) == 21
  end
end
