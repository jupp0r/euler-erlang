ExUnit.start

require Integer

defmodule Problem73 do
  use ExUnit.Case
  def problem73 do
    1..12000 |>
      Enum.map(&({&1, proper_fraction_nominators(&1)})) |>
      Enum.map(fn {x, proper_fraction_nominators} ->
        Enum.count(proper_fraction_nominators, fn y ->
          y/x > 1/3 and y/x < 1/2 end) end) |>
      Enum.sum |>
      IO.puts
  end

  defp proper_fraction_nominators n do
    Enum.filter(1..n, &(:euler_helper.gcd(&1,n) == 1))
  end

  test "proper_fraction_nominators" do
    assert proper_fraction_nominators(2) == [1]
    assert proper_fraction_nominators(8) == [1, 3, 5, 7]
  end
end
