ExUnit.start

defmodule Problem61 do
  use ExUnit.Case

  def problem61 do
    triangle_set = create_figurate_set(&triangle_fun/1)
    square_set = create_figurate_set(&square_fun/1)
    pentagonal_set = create_figurate_set(&pentagonal_fun/1)
    hexagonal_set = create_figurate_set(&hexagonal_fun/1)
    heptagonal_set = create_figurate_set(&heptagonal_fun/1)
    octagonal_set = create_figurate_set(&octagonal_fun/1)
    set_list = [triangle_set, square_set, pentagonal_set, hexagonal_set , heptagonal_set, octagonal_set]
    find_permuted_figurate_cycles(:lists.map(&:sets.to_list/1, set_list)) |> Enum.sum
  end

  defp triangle_fun(n) do 
    div(n*(n+1),2)
  end

  defp square_fun(n) do
    n*n
  end

  defp pentagonal_fun(n) do
    div(n*(3*n-1),2)
  end
                      
  defp hexagonal_fun(n) do
    n*(2*n-1)
  end

  defp heptagonal_fun(n) do
    div(n*(5*n-3), 2)
  end
                      
  defp octagonal_fun(n) do
    n*(3*n-2)
  end

  defp find_permuted_figurate_cycles (number_lists) do
    permutations = :euler_helper.perms number_lists
    results = permutations |> Enum.map(&find_figurate_cycles/1)
    solution = results |> Enum.find(fn(x) -> x != [] end)
    solution
  end
  
  defp find_figurate_cycles([first_list | rest_lists]) do
    find_figurate_cycles(rest_lists, first_list)
  end

  defp find_figurate_cycles(_, []) do
    []
  end

  defp find_figurate_cycles(rest, [h|t]) do
    case discover_branch(rest, [h]) do
      [] ->
        find_figurate_cycles(rest,t)
      result ->
        result
    end
  end
  
  defp discover_branch([], result) do
    result
  end

  defp discover_branch([head_list | rest], [result_head | result_rest]) do
    result_front_digits = div(result_head,100)
    filter_function = case rest do
                        [] ->
                        fn (x) ->
                          result_back_digits = :lists.reverse(result_rest) |> hd |> rem(100)
                          rem(x, 100) == result_front_digits && div(x,100) == result_back_digits
                        end
                        _ -> fn (x) ->
                          rem(x, 100) == result_front_digits
                        end
                      end
    
    filtered_list = :lists.filter(filter_function, head_list)
                                                                          
    branch_list = :lists.map(fn(x) ->
      case discover_branch(rest, [x] ++ [result_head | result_rest]) do
        [] ->
          []
        result ->
          result
      end
    end, filtered_list)
    case :lists.dropwhile(fn(x) -> x == [] end, branch_list) do
      [] ->
        []
      res ->
        hd(res)
    end
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

  test "find_figurative_cycles according to problem example" do
    triangle_set = create_figurate_set(&triangle_fun/1)
    square_set = create_figurate_set(&square_fun/1)
    pentagonal_set = create_figurate_set(&pentagonal_fun/1)
    assert :lists.sort(find_figurate_cycles(:lists.map(&:sets.to_list/1, [triangle_set, square_set, pentagonal_set]))) == [2882, 8128, 8281]
  end
end
