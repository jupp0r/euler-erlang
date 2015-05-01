ExUnit.start

require Integer
require Euler

defmodule Problem65 do
  use ExUnit.Case

  def problem65 do
    {p, _} = continued_fraction(100)
    p |> :euler_helper.int_to_digit_list |> Enum.sum
  end

  defp continued_fraction(k) do
    {p, d, _} = continued_fraction(k, Map.new)
    {p, d}
  end
  defp continued_fraction(1, lookup) do
    {2,1, Map.put(lookup, 1, {2,1})}
  end
  defp continued_fraction(2, lookup) do
    {3,1, Map.put(lookup, 2, {3,1})}
  end
  defp continued_fraction(k, lookup) do
    {p2, d2, nlookup} = lookup_or_create k-2, lookup
    {p1, d1, n2lookup} = lookup_or_create k-1, nlookup
    an = cond do
      rem(k,3) == 0 ->
        2*(div k, 3)
      true ->
        1
    end
    {an*p1+p2, an*d1 + d2, Map.put(n2lookup, k, {an*p1+p2, an*d1 + d2})}
  end

  defp lookup_or_create k, lookup do
    case Map.get(lookup,k) do
      nil ->
        continued_fraction k, lookup
      {p, n} ->
        {p, n, lookup}
    end
  end

  test "continued_fraction" do
    # from projecteuler
    assert continued_fraction(7) == {106,39}
    assert continued_fraction(10) == {1457,536}
  end

end
