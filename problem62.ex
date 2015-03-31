ExUnit.start

defmodule Problem62 do
  use ExUnit.Case

  def problem62 do
    find_cubes
  end

  def find_cubes do
    find_cubes 1, HashSet.new
  end

  def find_cubes n, set do
    IO.puts inspect(n*n*n)
    cond do
      Enum.count(set, fn(x) -> is_permutation?(n*n*n,x) end) == 4 ->
        set |> Enum.filter(fn(x) -> is_permutation?(n*n*n, x) end) |> Enum.sort |> hd
      true->
        find_cubes n+1, HashSet.put(set, n*n*n)
    end
  end

  def is_permutation? a, b do
    :euler_helper.int_to_digit_list(a) |> Enum.sort == :euler_helper.int_to_digit_list(b) |> Enum.sort
  end
end
