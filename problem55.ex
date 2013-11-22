ExUnit.start

defmodule Problem55 do
  use ExUnit.Case

  def problem55 do
    find_lychrel(9999,50,2*9999)
  end
  
  defp find_lychrel(0,_,_) do
    0
  end
  defp find_lychrel(n,0,_) do
    1 + find_lychrel(n-1,50, n-1 + reverse(n-1))
  end
  defp find_lychrel(n,k,j) do
    if :euler_helper.number_is_palindromic(j) do
      find_lychrel(n-1, 50, n-1 + reverse(n-1))
    else
      find_lychrel(n, k-1, j + reverse(j))
    end
  end

  defp reverse(n) do
    :euler_helper.digit_list_to_int(:lists.reverse(:euler_helper.int_to_digit_list(n)))
  end

  test "reverse" do
    assert reverse(249) == 942
  end
end
