ExUnit.start

require Integer
import Euler

defmodule Problem64 do
  use ExUnit.Case

  def problem64 do
    count_odd_periods_upto(10000)
  end

  defp count_odd_periods_upto(n) do
    max_digit_count = 2000
    square_limit = :math.sqrt(n) |> round
    search_limit = square_limit*square_limit
    square_list = 2..square_limit |> Enum.map(fn(x) -> x*x end)
    2..search_limit |>
      pputs("Filtering squares ...") |>
      Enum.filter(fn(x) -> not Enum.member? square_list, x end) |>
      pputs("Computing coefficient lists ...") |>
      Enum.map(fn(x) -> get_coefficient_list(x, max_digit_count) end) |>
      pputs("Computing loop lenghts ...") |>
      Enum.map(&:euler_helper.loop_len/1) |>
      pputs("Filtering odd loop lenghts ...") |>
      Enum.filter(&Integer.is_odd/1) |>
      pputs("Counting ...") |>
      Enum.count
  end

  defp digit_list_to_string(digit_list) do
    digit_list |>
      Enum.map(&Integer.to_string/1) |>
      Enum.join |>
      String.to_char_list
  end

  test "conut_odd_periods_upto" do
    assert count_odd_periods_upto(13) == 4
  end

  test "compute_coefficients" do
    assert next_coefficients(1,23,-4) == {1, 23, -3, 7}
    assert next_coefficients(7,23,-3) == {3, 23, -3, 2}
  end

  test "get_coefficient_list" do
    # from projecteuler
    assert get_coefficient_list(2,10) == [1,2,2,2,2,2,2,2,2,2]
    assert get_coefficient_list(3,10) == [1,1,2,1,2,1,2,1,2,1]
    assert get_coefficient_list(5,10) == [2,4,4,4,4,4,4,4,4,4]
    assert get_coefficient_list(6,10) == [2,2,4,2,4,2,4,2,4,2]
    assert get_coefficient_list(7,10) == [2,1,1,1,4,1,1,1,4,1]
    assert get_coefficient_list(8,10) == [2,1,4,1,4,1,4,1,4,1]
    assert get_coefficient_list(10,10) == [3,6,6,6,6,6,6,6,6,6]
    assert get_coefficient_list(11,10) == [3,3,6,3,6,3,6,3,6,3]
    assert get_coefficient_list(12,10) == [3,2,6,2,6,2,6,2,6,2]
    assert get_coefficient_list(13,20) == [3,1,1,1,1,6,1,1,1,1,6,1,1,1,1,6,1,1,1,1]
    # weird cases
    assert get_coefficient_list(9,10) == [3]
    assert get_coefficient_list(3482,1) == [59]
  end

  test "pputs" do
    assert pputs(4, "lala") == 4
  end

  test "digit_list_to_string" do
    assert digit_list_to_string([3,4,3,6]) == '3436'
  end

  test "list_loop_len" do
    assert :euler_helper.loop_len([1, 98, 1, 198, 1, 98, 1, 198, 1, 98, 1, 198]) == 4
    assert :euler_helper.loop_len(get_coefficient_list(2,10)) == 1
    assert :euler_helper.loop_len(get_coefficient_list(3,10)) == 2
    assert :euler_helper.loop_len(get_coefficient_list(13,100)) == 5
    assert :euler_helper.loop_len("1121212121" |> String.to_char_list) == 2
    assert :euler_helper.loop_len("1234123412" |> String.to_char_list) == 4
    assert :euler_helper.loop_len("111115111115" |> String.to_char_list) == 6
    assert :euler_helper.loop_len('31111611116111161111') == 5
    assert :euler_helper.loop_len('1234568') == 0
    assert :euler_helper.loop_len('1234568') == 0
    assert :euler_helper.loop_len([10, 1, 2, 1, 1, 1, 1, 1, 2, 1, 20, 1, 2, 1, 1, 1, 1, 1, 2, 1, 20, 1, 2, 1, 1, 1, 1, 1, 2, 1, 20, 1, 2]) == 10
  end
end
