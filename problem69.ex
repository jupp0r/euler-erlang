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
end
