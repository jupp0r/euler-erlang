ExUnit.start

require Integer

defmodule Problem74 do
  use ExUnit.Case

  def problem74 do
    1..999999 |>
      Enum.map(&factorial_chain/1) |>
      Enum.map(&Enum.count/1) |>
      Enum.count(&(&1 == 60)) |>
      IO.puts
  end

  defp factorial_chain n do
    factorial_chain_list([n]) |> Enum.reverse
  end

  defp factorial_chain_list [h|t] do
    case Enum.member?(t, h) do
      true -> t
      false ->
        next_head = :euler_helper.int_to_digit_list(h) |>
          Enum.map(&:euler_helper.fac/1) |>
          Enum.sum
        factorial_chain_list([next_head,h] ++ t)
    end
  end

  test "factorial_cain" do
    assert factorial_chain(169) == [169, 363601, 1454]
  end
end
