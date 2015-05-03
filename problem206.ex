ExUnit.start

require Integer
import Euler

defmodule Problem206 do
  use ExUnit.Case

  def problem206 do
    squares = Stream.resource(
      fn -> 1 end,
      fn x ->
        a = div(rem(x, 10), 1)
        b = div(rem(x, 100), 10)
        c = div(rem(x, 1000), 100)
        d = div(rem(x, 10000), 1000)
        e = div(rem(x, 100000), 10000)
        f = div(rem(x, 1000000), 100000)
        g = div(rem(x, 10000000), 1000000)
        h = div(rem(x, 100000000), 10000000)
        #1_2_3_4_5_6_7_8_9_0
        seq_num = (9*rp(10,0) + rp(10,1)*a + 8*rp(10,2) + rp(10,3)*b + 7*rp(10,4) + rp(10,5)*c + 6*rp(10,6) + rp(10,7)*d + 5*rp(10,8) + rp(10,9)*e + 4*rp(10,10) + rp(10,11)*f + 3*rp(10,12) + rp(10,13)*g + 2*rp(10,14) + rp(10,15)*h + rp(10,16))
#        IO.puts seq_num
        {[seq_num*100], x+1}
      end,
      &(&1)
    )
    k = Enum.find(squares, fn x ->
      sqrt = round(:math.sqrt(x))
      sqrt*sqrt == x
    end
    ) |> :math.sqrt
    IO.puts k
  end

  defp rp n,x do
    :math.pow(n,x) |> round
  end
end
