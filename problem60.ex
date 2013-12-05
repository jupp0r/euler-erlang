ExUnit.start

defmodule Problem60 do
  use ExUnit.Case

  @maxprimes 50000

  def problem60 do
    primes = :euler_helper.calc_sieve(@maxprimes)
    possible_combinations = lc(a inlist primes,
                               a < 14,
                               b inlist primes,
                               b > a,
                               pairs_prime([a,b]),
                               c inlist primes,
                               c > b,
                               pairs_prime([a,b,c]),
                               d inlist primes,
                               d > c,
                               pairs_prime([a,b,c,d]),
                               e inlist primes,
                               e > d,
                               pairs_prime([a,b,c,d,e]),
                               do:
                               :lists.sum([a,b,c,d,e]))
    hd(:lists.sort(possible_combinations))
  end

  defp pairs_prime(l) do
    head = hd(l)
    len = length(l)
    Enum.all?(pairs(l), fn([x,y]) -> :euler_helper.prime(concatenate_numbers(x,y)) and :euler_helper.prime(concatenate_numbers(y,x)) end) and IO.puts "#{head} #{len}"
  end

  defp concatenate_numbers(a,b) do
    :euler_helper.digit_list_to_int(:euler_helper.int_to_digit_list(a) ++ :euler_helper.int_to_digit_list(b))
  end

  def pairs(l) do
    lc x inlist l, y inlist l, x != y, do: [x,y]
  end

  #tests
  test "concatenate_numbers" do
    assert concatenate_numbers(123,123) == 123123
  end

  test "pairs" do
    assert pairs([1,2,3]) == [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
  end

  test "pairs_prime" do
    assert pairs_prime([3,7,109,673])
    assert not pairs_prime([2,5,109,673])
  end
end
