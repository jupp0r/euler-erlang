ExUnit.start

require Integer
import Euler

defmodule Problem68 do
  use ExUnit.Case

  def problem68 do
    backtrack_fivegon |>
      Enum.map(&reorder_path/1) |>
      Enum.uniq |>
      Enum.map(&Enum.join/1) |>
      Enum.sort |>
      Enum.max |>
      inspect |>
      IO.puts
  end

  defp backtrack_fivegon do
    backtrack_fivegon Enum.to_list(1..9), [10]
  end

  defp backtrack_fivegon remaining_numbers, path do
    case check_path path do
      :ok ->
        case length(path) do
          10 ->
            [path]
          _ ->
            Enum.reduce(remaining_numbers, [],
              fn x,acc ->
                acc ++ backtrack_fivegon(remaining_numbers -- [x], path ++ [x])
              end
            )
        end
      :cut ->
        []
    end
  end

  defp check_path(path) do
    case length(path) do
      x when x < 5 -> :ok
      _ ->
        segments = Enum.chunk(path, 3, 2)
        newsegments =
          case path do
            [_,a2,_,_,_,_,_,_,x1,x2] -> segments ++ [[x1,a2,x2]]
            _ -> segments
          end
        case newsegments |> Enum.map(&Enum.sum/1) |> Enum.uniq |> length do
          1 ->
            :ok
          _ -> :cut
        end
    end
  end

  defp reorder_path path do
    [a1,a2,a3,a4,a5,a6,a7,a8,a9,a10] = path
    segments = [[a1,a2,a3], [a4,a3,a5], [a6,a5,a7], [a8,a7,a9], [a10,a9,a2]]
    edge_nodes = segments |> Enum.map(&hd/1)
    min = edge_nodes |> Enum.min
    min_index = edge_nodes |> Enum.find_index(&(&1 == min))
    reordered_segments = Enum.concat([
      Enum.slice(segments, min_index, 1),
      Enum.slice(segments, (min_index+1)..length(segments)),
      Enum.slice(segments, 0..(min_index-1))])
    reordered_segments |> List.flatten
  end
end
