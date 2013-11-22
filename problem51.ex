ExUnit.start

defmodule Problem51 do
  use ExUnit.Case

  def problem51 do
    primes = :euler_helper.calc_sieve(1000000)
    fast_primes = :gb_sets.from_list(primes)
    found_prime = Enum.find(primes, fn(x) ->
                          digit_replacement_count(x,fast_primes) == 8
                      end)
    found_prime
  end
  
  defp replace_digits(n, digit, replacement) do
    digits = :euler_helper.int_to_digit_list(n)
    newdigits = List.replace_at(digits, digit, replacement)
    :euler_helper.digit_list_to_int(newdigits)
  end

  defp possible_digit_replacements(n) do
    digit_list = :lists.seq(0,n-1)
    possible_digit_replacements_work(digit_list) -- [digit_list]
  end
  
  defp possible_digit_replacements_work([]) do
    []
  end
  defp possible_digit_replacements_work([h|t]) do
    combinations = possible_digit_replacements_work(t)
    [[h]] ++ lc l inlist combinations do [h|l] end ++ combinations
  end

  defp digit_replacement_count(number, primes) do
    digits = :euler_helper.int_to_digit_list(number)
    number_of_digits = Enum.count(digits)
    possible_replacements = possible_digit_replacements(number_of_digits)
    prime_replacements = lc x inlist possible_replacements do
      :lists.usort(
                   lc k inlist :lists.seq(0,9), maybeprime inlist [mass_replace(number,x,k)], Enum.count(:euler_helper.int_to_digit_list(maybeprime)) == number_of_digits, :gb_sets.is_element(maybeprime, primes) do
                     maybeprime
                   end)
    end
    filtered_replacements = Enum.filter(prime_replacements,fn(x) -> Enum.member?(x, number) end)
    count_list = lc x inlist filtered_replacements, do: Enum.count(x)
    case count_list do
      [] ->
        0
      _ ->
        :lists.max(count_list)
    end
  end


  defp mass_replace(number, list, replacement) do
    List.foldl(list, number, fn(x,acc) -> replace_digits(acc, x, replacement) end)
  end

  # tests
  test "replace_digits" do
    assert replace_digits(12,1,1) == 11
    assert replace_digits(1224,2,3) == 1234
  end

  test "possible_digit_replacements" do
    assert possible_digit_replacements(2) == [[0],[1]]
    assert possible_digit_replacements(3) == [[0],[0,1],[0,2],[1],[1,2],[2]]
  end

  test "digit_replacement_count" do
    primes = :gb_sets.from_list(:euler_helper.calc_sieve(100000))
    assert digit_replacement_count(56003, primes) == 7
  end

  test "mass_replace" do
    assert mass_replace(1111,[1,2],2) == 1221
  end
end
