ExUnit.start

require Bitwise

defmodule Problem59 do
  use ExUnit.Case

  @maxsearch 40000

  def problem59 do
    binary = File.binstream!("problem59.txt", [], :line)
    cipher = Enum.reduce binary, [], fn(x, acc) -> acc ++ [String.rstrip(x)] end
    charlist = String.split(hd(cipher), ",")
    ascii_cipher = lc x inlist charlist, do: Kernel.binary_to_integer x
    keys = search_key(ascii_cipher)
    case keys do
      :notfound ->
        IO.puts "Key not found!"
      {a,b,c} ->
        :lists.sum decrypt(ascii_cipher,a,b,c)
    end
  end

  defp search_key(cipher) do
    keyspace = :lists.seq(?a,?z)
    keys = lc a inlist keyspace, b inlist keyspace, c inlist keyspace, do: {a,b,c}
    search_key(cipher, cipher, keys, 0)
  end

  defp search_key(_,[],[keys|_],_) do
    keys
  end
  defp search_key(_,_,[],_) do
    :notfound
  end
  defp search_key(cipher,[h|t],[keys|nextkeys],n) do
    {a,b,c} = keys
    continue = cond do
      rem(n,3) == 0 ->
        check_char(Bitwise.bxor(h,a))
      rem(n,3) == 1 ->
        check_char(Bitwise.bxor(h,b))
      rem(n,3) == 2 ->
        check_char(Bitwise.bxor(h,c))
    end
    if continue do
      search_key(cipher,t,[keys|nextkeys],n+1)
    else
      search_key(cipher,cipher,nextkeys,0)
    end
  end

  def check_char(n) do
    n in [3, 4, 9, 10, 13, ? , ?,, ?., ?!, ??, ?", ?', ?%, ?(, ?), ?&, ?;] or n in ?A..?Z or n in ?0..?9 or n in ?a..?z
  end

  defp decrypt(text, char_a, char_b, char_c) do
    {_, decrypted_text} = List.foldl(text,{0,text}, fn(x,{n,newtext}) ->
                                                        cond do
                                                          rem(n,3) == 0 ->
                                                            {n+1, replace_nth(newtext, n, Bitwise.bxor(x, char_a))}
                                                          rem(n,3) == 1 ->
                                                            {n+1, replace_nth(newtext, n, Bitwise.bxor(x, char_b))}
                                                          rem(n,3) == 2 ->
                                                            {n+1, replace_nth(newtext, n, Bitwise.bxor(x, char_c))}
                                                        end
                                                    end)
    decrypted_text
  end
  
  defp replace_nth(text, 0, new) do
    [new] ++ :lists.nthtail(1, text)
  end
  defp replace_nth(text, place, new) when place - 1 == length(text) do
    :lists.sublist(text, place - 1) ++ [new]
  end
  defp replace_nth(text, place, new) do
    :lists.sublist(text, place) ++ [new] ++ :lists.nthtail(place + 1, text)
  end

  # tests
  test "replace_nth" do
    assert replace_nth([3,2,3],1,3) == [3,3,3]
  end

end
