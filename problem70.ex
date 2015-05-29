ExUnit.start

require Integer
import Euler

defmodule Problem70 do
  use ExUnit.Case
  def problem70 do
    primes = :euler_helper.calc_sieve(5000)
    filtered_primes = primes |>
      Enum.filter(&(&1 > 2000))
    reduced_prime_products = for x <- filtered_primes, y <- filtered_primes, do: {x*y, (x-1)*(y-1)}
    reduced_prime_products |>
      Enum.filter(fn {x, a} -> x < :euler_helper.int_pow(10,7) and is_permutation?(x,a) end ) |>
      Enum.min_by(fn {x, a} -> x/a end) |>
      inspect |>
      IO.puts
  end
end
