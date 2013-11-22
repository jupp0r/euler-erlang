ExUnit.start

defmodule Problem57 do
  use ExUnit.Case

  def problem57 do
    series = series_generator(1000)
    filtered_series = Enum.filter(series, fn({a,b}) -> length(:euler_helper.int_to_digit_list(a)) > length(:euler_helper.int_to_digit_list(b)) end)
    length(filtered_series)
  end

  defp series_generator(n) do
    [{3,2}] ++ series_generator(1,n,{3,2})
  end

  defp series_generator(n,n,_) do
    []
  end
  defp series_generator(k,n,{a,b}) do
    new_fraction = {a+2*b,a+b}
    [new_fraction] ++ series_generator(k+1,n,new_fraction)
  end


  test "series_generator" do
    assert series_generator(4) == [{3,2},{7,5},{17,12},{41,29}]
  end
end
