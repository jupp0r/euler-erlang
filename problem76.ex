ExUnit.start

require Integer
import Euler

defmodule Problem76 do
  use ExUnit.Case

  def problem76 do
    {_, p} = Enum.find(partition_count_stream, fn {n, _} -> n == 100 end)
    IO.puts p-1
  end
end
