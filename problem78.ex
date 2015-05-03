ExUnit.start

require Integer
import Euler

defmodule Problem78 do
  use ExUnit.Case

  def problem78 do
    IO.puts inspect(Enum.find(partition_count_stream, fn ({_,r}) -> rem(r, 1000000) == 0 end))
  end
end
