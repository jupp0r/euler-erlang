ExUnit.start

require Integer

defmodule Problem77 do
  use ExUnit.Case

  def problem77 do
    find_prime_sum_greater_than(5000) |> IO.puts
  end

  defp find_prime_sum_greater_than n do
    find_prime_sum_greater_than 10,n
  end

  defp find_prime_sum_greater_than k,n do
    cond do
      prime_sum_combinations(k) >= n ->
        k
      true ->
        find_prime_sum_greater_than k+1, n
    end
  end

  defp prime_sum_combinations n do
    prime_sum_combinations(n,(n-1)..2 |> Enum.to_list |> Enum.filter(&:euler_helper.prime/1),0)
  end

  defp prime_sum_combinations n,[],n do
    1
  end

  defp prime_sum_combinations _,[],_ do
    0
  end

  defp prime_sum_combinations(n, [h|t], k) when h+k == n do
    1 + prime_sum_combinations n, t, k
  end

  defp prime_sum_combinations(n, [h|t], k) when h+k < n do
    prime_sum_combinations(n, [h|t], k+h) + prime_sum_combinations(n, t, k)
  end

  defp prime_sum_combinations(n, [h|t], k) when h+k > n do
    prime_sum_combinations n,t,k
  end

  test "prime_sum_combinations" do
    assert prime_sum_combinations(10) == 5
  end
end
