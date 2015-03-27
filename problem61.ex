ExUnit.start

defmodule Problem61 do
  use ExUnit.Case

  def problem61 do
    triangle_fun = fn(n) -> div(n*(n+1),2) end
    square_fun = fn(n) -> n*n end
    pentagonal_fun = fn(n) -> n*div((3*n-1),2) end
    hexagonal_fun = fn(n) -> n*(2*n-1) end
    heptagonal_fun = fn(n) -> n*div((5*n-3),2) end
    octagonal_fun = fn(n) -> n*(3*n-2) end
    triangle_set = create_figurate_set(triangle_fun)
    square_set = create_figurate_set(square_fun)
    pentagonal_set = create_figurate_set(pentagonal_fun)
    hexagonal_set = create_figurate_set(hexagonal_fun)
    heptagonal_set = create_figurate_set(heptagonal_fun)
    octagonal_set = create_figurate_set(octagonal_fun)
    set_list = [triangle_set, square_set, pentagonal_set] #, hexagonal_set , heptagonal_set, octagonal_set]
    find_figurate_cycles(set_list)
  end
  
  defp find_figurate_cycles(set_list) do
    [triangle_set | rest_list] = set_list
    permutations = :euler_helper.perms(rest_list)
    find_figurate_cycles(:sets.to_list(triangle_set), permutations)
  end

  defp find_figurate_cycles([],_) do
    []
  end

  defp find_figurate_cycles(_,[]) do
    []
  end

  defp find_figurate_cycles([triangle_num|triangle_rest], [permutation|rest_permutations]) do
    cut_results = discover_branch(triangle_num, permutation)
    case cut_results do
      [] ->
        find_figurate_cycles([triangle_num|triangle_rest], rest_permutations) ++ find_figurate_cycles(triangle_rest, [permutation|rest_permutations])
      _ ->
        cut_results
    end
  end

  defp discover_branch(number, permutation) do
    :lists.reverse(discover_branch([number], permutation, []))
  end

  defp discover_branch([],_,_) do
    []
  end

  defp discover_branch([last|rest],[], results) do 
    first_digits = div(hd(results),100)
    last_digits  = rem(last,100)
    cond do
      first_digits == last_digits ->
        [last | results]
      true ->
        discover_branch(rest, [], results)
    end
  end

  defp discover_branch([last_number | rest_numbers], [this_set | rest_sets], results) do
    last_digits = rem(last_number, 100)
    search_space = :lists.seq(last_digits*100,last_digits*100+99)
    search_set = :sets.from_list(search_space)
    intersection = :sets.intersection(this_set, search_set)
    result_set = :sets.from_list(results)
    intersection_without_results = :sets.subtract(intersection, result_set)
    intersection_list = :sets.to_list(intersection_without_results)
    discover_branch(intersection_list, rest_sets, results ++ [last_number]) ++ discover_branch(rest_numbers, [this_set | rest_sets], results)
  end

  defp create_figurate_set(fun) do
    search_set = :sets.new
    create_figurate_set(search_set,fun,1, 1000, 9999)
  end

  defp create_figurate_set(search_set, fun, n, min, max) do
    number = fun.(n)
    cond do
      number < min -> 
        create_figurate_set(search_set, fun, n+1, min, max)
      number > max -> 
        search_set
      true ->
        new_set = :sets.add_element(number,search_set)
        create_figurate_set(new_set, fun, n+1, min, max)
    end
  end

  test "create_figurate_set" do
    assert :lists.sort(:sets.to_list(create_figurate_set(:sets.new, fn(n) -> div(n*(n+1),2) end,1, 10, 20))) == [10,15]
  end

  test "discover_branch yields positive results" do
    assert discover_branch(1122, [:sets.from_list([2233, 1234]), :sets.from_list([3311, 3423])]) == [1122, 2233, 3311]
  end

  test "discover_branch yields negative results" do
    assert discover_branch(1127, [:sets.from_list([2233, 1234]), :sets.from_list([3311, 3423])]) == []
  end
end
