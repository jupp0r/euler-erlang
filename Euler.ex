ExUnit.start

require Integer

defmodule Euler do
  use ExUnit.Case

  def pputs(data, string) do
    IO.puts string
    data
  end

  def get_coefficient_list(n, limit) do
    root = :math.sqrt(n) |> Float.floor
    list = cond do
      root * root == n ->
        [root]
      true ->
        {k, p, r, s} = first_coefficients(n)
        [k] ++ get_coefficient_list_(p, r, s, limit-1)
    end |>
    Enum.map(&round/1)
    IO.puts "#{n},#{:euler_helper.loop_len(list)}: #{inspect(list, char_lists: false)}"
    list
  end

  defp get_coefficient_list_(_,_,_,0) do
    []
  end

  defp get_coefficient_list_(p, r, s, limit) do
    {k, _, ns, np} = next_coefficients(p, r, s)
    [k] ++ get_coefficient_list_(np, r, ns, limit - 1)
  end

  defp first_coefficients(n) do
    first_summand = n |> :math.sqrt |> Float.floor
    {first_summand, 1, n, -first_summand}
  end

  defp next_coefficients(nominator, root, summand_part) do
    sqrt = :math.sqrt(root)
    next_nominator = (root-summand_part*summand_part) / nominator
    ak = (sqrt - summand_part) * nominator/(root-summand_part*summand_part)
    next_coefficient = Float.floor(ak)
    next_summand = -(next_coefficient*next_nominator+summand_part)
    {next_coefficient, root, next_summand, next_nominator}
  end

  def partition_count_stream do
    Stream.resource(
      fn ->
        {1, Map.new}
      end,
      fn {x, cache} ->
        new_result = partition_count(x, cache)
#        IO.puts "#{x} -> #{new_result}"
        {[{x,new_result}], {x+1, Map.put(cache, x, new_result)}}
      end,
      &(&1))
  end

  defp partition_count(n,_) when n < 0 do
    0
  end
  defp partition_count 0,_ do
    1
  end
  defp partition_count 1,_ do
    1
  end
  defp partition_count n, cache do
    produce_generalized_pentagonal_number_stream |>
      Enum.take_while(&((n > &1) or (n == &1))) |>
      Enum.map(&(lookup_or_compute_partition_count(cache, n-&1))) |>
      Stream.zip(Stream.cycle([1,1,-1,-1])) |>
      Enum.map(fn ({a,b}) -> a*b end) |>
      Enum.sum
  end

  defp produce_generalized_pentagonal_number_stream do
    Stream.resource(
      fn -> 1 end,
      fn x ->
        {[round((3*x*x-x)/2), round((3*x*x+x)/2)], x+1}
      end,
      &(&1)
    )
  end

  defp lookup_or_compute_partition_count cache, n do
    case Map.has_key? cache, n do
      true ->
        Map.get(cache, n)
      false ->
        partition_count(n, cache)
    end
  end

  def euler_phi n do
    distinct_prime_divisors = :euler_helper.divisors(n) |> Enum.filter(&:euler_helper.prime/1)
    Enum.reduce(distinct_prime_divisors, 1,
      fn x,acc ->
        acc*(1-1/x)
      end
    ) * n |> round
  end

  def is_permutation? a, b do
    :euler_helper.int_to_digit_list(a) |> Enum.sort == :euler_helper.int_to_digit_list(b) |> Enum.sort and a != b
  end

  test "is_permutation" do
    assert is_permutation?(5,5) == false
    assert is_permutation?(23,32) == true
  end
end
