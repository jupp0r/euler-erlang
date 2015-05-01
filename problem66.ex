ExUnit.start

require Integer
import Euler

defmodule Problem66 do
  use ExUnit.Case

  def problem66 do
    max = 1000
    squares = 1..round(Float.ceil(:math.sqrt(max))) |> Enum.map &(&1*&1)

    maxpair = 2..max |>
      pputs("Filtering squares") |>
      Enum.filter(&(! Enum.member?(squares, &1))) |>
      pputs("Constructing streams")|>
      Enum.map(&({&1, fraction_stream(&1)})) |>
      pputs("Solving Equations") |>
      Enum.map(
        fn ({d, stream}) ->
          {_,x,_} = Enum.find(stream, fn({_,hn,kn}) -> hn*hn-d*kn*kn == 1 end)
          {d, x}
        end
      ) |>
      pputs("Finding Max x") |>
      Enum.reduce({-1, 0}, fn ({d,x}, {oldd, max}) -> if x > max, do: {d, x}, else: {oldd, max} end)
    {maxd, _} = maxpair
    IO.puts maxd
  end

  defp fraction_stream n do
    Stream.resource(
      fn -> {{0,1},{1,0}, {:math.sqrt(n) |> Float.floor |> round, 0, 1}, n} end,
      fn {{hn2,kn2}, {hn1,kn1}, {an, mn, dn}, n} ->
        a0 = :math.sqrt(n) |> Float.floor |> round
        mn1 = dn * an - mn
        dn1 = (n - mn1*mn1) / dn
        an1 = ((a0 + mn1)/dn1) |> Float.floor |> round
        hn = an*hn1 + hn2
        kn = an*kn1 + kn2
        accumulator = {{hn1, kn1},
                       {hn, kn},
                       {an1, mn1, dn1},
                       n}
        {[{an, hn, kn}], accumulator}
      end,
      &(&1)
    )
  end

  test "fraction_stream" do
    assert (fraction_stream(3) |> Enum.take(6)) == [{1,1,1}, {1,2,1}, {2,5,3}, {1,7,4}, {2,19,11}, {1,26,15}]
    assert Enum.find(fraction_stream(3), fn ({_,_,c}) -> c == 4 end) == {1,7,4}
  end
end
