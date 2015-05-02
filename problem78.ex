ExUnit.start

require Integer
import Euler

defmodule Problem78 do
  use ExUnit.Case

  def problem78 do
    partition_count_stream = Stream.resource(
      fn ->
        {1, Map.new}
      end,
      fn {x, cache} ->
        new_result = partition_count(x, cache)
#        IO.puts "#{x} -> #{new_result}"
        {[{x,new_result}], {x+1, Map.put(cache, x, new_result)}}
      end,
      &(&1)
    )
    IO.puts inspect(Enum.find(partition_count_stream, fn ({_,r}) -> rem(r, 1000000) == 0 end))
  end

  defp partition_count(n) do
    partition_count(n, Map.new)
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
      Enum.map(&(lookup_or_compute(cache, n-&1))) |>
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

  defp lookup_or_compute cache, n do
    case Map.has_key? cache, n do
      true ->
        Map.get(cache, n)
      false ->
        partition_count(n, cache)
    end
  end

  defp dump_stream(l) do
    IO.puts(l |> inspect)
    l
  end

  test "partition_count" do
#    assert partition_count(100) == 190569292
    assert partition_count(1) == 1
    assert partition_count(2) == 2
    assert partition_count(3) == 3
    assert partition_count(4) == 5
    assert partition_count(5) == 7
    assert partition_count(6) == 11
    assert partition_count(7) == 15
    assert partition_count(8) == 22
  end
end
