ExUnit.start

require Integer

defmodule Problem75 do
  use ExUnit.Case

  def problem75 do
    triplet_sums(1,1,1,HashDict.new) |>
      Dict.values |>
      Enum.count(&(&1 == 1)) |>
      IO.puts
  end

  defp triplet_sums(m,_,_,sum_count_dict) when m > 1500000 do
    sum_count_dict
  end

  defp triplet_sums(_,_,k,sum_count_dict) when k > 1500000 do
    sum_count_dict
  end

  defp triplet_sums(m,n,_k,sum_count_dict) when m <= n do
    triplet_sums m+1,1,1,sum_count_dict
  end

  defp triplet_sums(m,n,k,sum_count_dict) when rem(m-n,2) == 0 do
    triplet_sums m,n+1,k,sum_count_dict
  end

  defp triplet_sums(m,n,k,sum_count_dict) when k*(m*m-n*n) + k*2*m*n + k*(m*m+n*n) > 1500000 do
    case k do
      1 ->
        triplet_sums m+1,1,1,sum_count_dict
      _ ->
        triplet_sums m,n+1,1,sum_count_dict
    end
  end

  defp triplet_sums m,n,k,sum_count_dict do
    case :euler_helper.gcd(m,n) do
      1 ->
        new_dict = insert_triplet_sum m,n,k,sum_count_dict
        triplet_sums m,n,k+1,new_dict
      _ ->
        triplet_sums m,n+1,1,sum_count_dict
    end
  end

  defp insert_triplet_sum m,n,k,sum_count_dict do
    a = k*(m*m-n*n)
    b = k*2*m*n
    c = k*(m*m+n*n)
    sum = a + b + c
    case Dict.fetch(sum_count_dict, sum) do
      {:ok, num_of_sums} ->
        Dict.put(sum_count_dict, sum, num_of_sums+1)
      _ ->
        Dict.put(sum_count_dict, sum, 1)
    end
  end
end
