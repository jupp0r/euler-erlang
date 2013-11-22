ExUnit.start

defmodule Problem58 do
  use ExUnit.Case

  @maxsearch 40000

  def problem58 do
    find_diagonal_prime_proportion(0.1)
  end

  defp find_diagonal_prime_proportion(fraction) do
    diagonal_list = :euler_helper.generate_diagonal_sequence(@maxsearch*@maxsearch)
    prime_diagonals = lc x inlist diagonal_list, :euler_helper.prime(x), do: x
    find_diagonal_prime_proportion fraction, 5, diagonal_list, prime_diagonals
  end

  defp find_diagonal_prime_proportion(fraction, n, diagonal_list, prime_diagonals) do
    diagonals = lc x inlist diagonal_list, x < n*n, do: x
    primes = lc x inlist prime_diagonals, x < n*n, do: x
    newfraction = length(primes)/length(diagonals)
    if newfraction <= fraction do
      n
    else
      find_diagonal_prime_proportion(fraction, n + 1, diagonal_list, prime_diagonals)
    end
  end
end
