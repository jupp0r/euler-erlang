ExUnit.start

defmodule Problem63 do
  use ExUnit.Case

  def problem63 do
    n_digits_power(1, 500) |> Enum.count
  end

  def n_digits_power 1, 0 do
    []
  end

  def n_digits_power 500, k do
    n_digits_power 1, k-1
  end

  def n_digits_power k, n do
    power = :euler_helper.int_pow(k, n)
    number_of_digits_of_power = :euler_helper.int_to_digit_list(power) |> Enum.count
    cond do
      number_of_digits_of_power == n ->
        IO.puts "#{k}^#{n} = #{power}"
        [power] ++ n_digits_power(k+1,n)
      number_of_digits_of_power > n ->
        n_digits_power(1,n-1)
      true ->
        n_digits_power(k+1,n)
    end
  end
end
