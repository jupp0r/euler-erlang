ExUnit.start

defmodule Problem53 do
  use ExUnit.Case

  def problem53 do
    nlist = :lists.seq(1,100)
    countlist = lc n inlist nlist do
      Enum.count(lc r inlist :lists.seq(0,n), ncr(n,r) > 1000000 do
        :ok
      end)
    end
    :lists.sum(countlist)
  end

  defp ncr(n,r) do
    :euler_helper.fac(n)/(:euler_helper.fac(r)*:euler_helper.fac(n-r))
  end

  test "ncr" do
    assert ncr(5,3) == 10
  end
end
