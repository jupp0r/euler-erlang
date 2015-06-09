ExUnit.start

require Integer

defmodule Problem80 do
  use ExUnit.Case

  def problem80 do
    squares = 1..100 |>
      Enum.map(&(&1*&1))

    1..100 |>
      Enum.filter(fn x ->
        not Enum.member?(squares, x)
      end) |>
      Enum.map(&sum_of_100_digits_of_root/1) |>
      Enum.sum |>
      inspect |>
      IO.puts
  end

  defp sum_of_100_digits_of_root n do
    n_expanded = n*:euler_helper.int_pow(10,210)
    newton_approximation(n_expanded, n_expanded ,0) |>
      :euler_helper.int_to_digit_list |>
      Enum.take(100) |>
      Enum.sum
  end

  defp newton_approximation(_, xn, iteration) when iteration > 10000 do
    xn
  end

  defp newton_approximation a, xn, iteration do
    next_xn = div(xn + div(a,xn), 2)
    newton_approximation a, next_xn, iteration+1
  end

  test "sum_of_100_digits_of_root" do
    assert sum_of_100_digits_of_root(2) == 475
  end

end
