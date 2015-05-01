defmodule Euler do

  def pputs(data, string) do
    IO.puts string
    data
  end

  def get_coefficient_list(n, limit) do
    root = :math.sqrt(n) |> Float.floor
    list = cond do
      root * root == n ->
        [root]
      true ->
        {k, p, r, s} = first_coefficients(n)
        [k] ++ get_coefficient_list_(p, r, s, limit-1)
    end |>
    Enum.map(&round/1)
    IO.puts "#{n},#{:euler_helper.loop_len(list)}: #{inspect(list, char_lists: false)}"
    list
  end

  defp get_coefficient_list_(_,_,_,0) do
    []
  end

  defp get_coefficient_list_(p, r, s, limit) do
    {k, _, ns, np} = next_coefficients(p, r, s)
    [k] ++ get_coefficient_list_(np, r, ns, limit - 1)
  end

  defp first_coefficients(n) do
    first_summand = n |> :math.sqrt |> Float.floor
    {first_summand, 1, n, -first_summand}
  end

  defp next_coefficients(nominator, root, summand_part) do
    sqrt = :math.sqrt(root)
    next_nominator = (root-summand_part*summand_part) / nominator
    ak = (sqrt - summand_part) * nominator/(root-summand_part*summand_part)
    next_coefficient = Float.floor(ak)
    next_summand = -(next_coefficient*next_nominator+summand_part)
    {next_coefficient, root, next_summand, next_nominator}
  end


end
