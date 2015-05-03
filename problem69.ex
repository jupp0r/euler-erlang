ExUnit.start

require Integer
import Euler

defmodule Problem69 do
  use ExUnit.Case

  def problem69 do
    x = 1..1000000 |>
      Enum.map(&({&1, euler_phi(&1)})) |>
      Enum.reduce({-1,-1},
        fn {n, phi_n},{maxn, max_calc} ->
          calc = n/phi_n
          if calc > max_calc, do: {n, calc}, else: {maxn, max_calc}
        end)
    IO.puts inspect(x)
  end

  defp euler_phi n do
    distinct_prime_divisors = :euler_helper.divisors(n) |> Enum.filter(&:euler_helper.prime/1)
    Enum.reduce(distinct_prime_divisors, 1,
      fn x,acc ->
        acc*(1-1/x)
      end
    ) * n |> round
  end

  test "euler_phi" do
    assert euler_phi(10) == 4
    assert euler_phi(70) == 24
  end
end
