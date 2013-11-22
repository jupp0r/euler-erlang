ExUnit.start

defmodule Problem54 do
  use ExUnit.Case, async: true

  def problem54 do
    binary = File.binstream!("problem54.txt", [], :line)
    hands = Enum.reduce binary, [], fn(x, acc) -> acc ++ [parse_hands(String.rstrip(x))] end
    Enum.count(lc {handa, handb} inlist hands, hand_better(handb, handa), do: :ok)
  end

  defp card_better(a,b) do
    {a_value, a_suit} = a
    {b_value, b_suit} = b
    
    if a_value != b_value do
      value_better(a_value, b_value)
    else
      suit_better(a_suit, b_suit)
    end
  end

  defp suit_better(a,b) do
    suit_map = [diamonds: 1, hearts: 2, spades: 3, clubs: 4]
    Keyword.get(suit_map, a) < Keyword.get(suit_map, b)
  end

  defp value_better(b,a) do
    value_map = [two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10, jack: 11, queen: 12, king: 13, ace: 14]
    Keyword.get(value_map, a) > Keyword.get(value_map, b) 
  end

  defp royal_flush(hand) do
    straight_flush(hand) and hand_contains([:ace,:king], hand)
  end

  defp hand_contains(contents, hand) do
    flat_hand = HashSet.new(List.flatten(Enum.map(hand, &tuple_to_list/1)))
    contents = HashSet.new contents
    HashSet.subset? contents, flat_hand
  end

  defp straight_flush(hand) do
    straight(hand) and flush(hand)
  end

  defp flush(hand) do
    suits = lc {_,suit} inlist hand, do: suit
    Enum.all?(suits, fn(x) -> x == hd(suits) end)
  end

  defp straight(hand) do
    value_map = [two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10, jack: 11, queen: 12, king: 13, ace: 14]
    values = :lists.sort(lc {val,_} inlist hand, do: value_map[val])
    values == :lists.seq(hd(values),hd(values)+4) or values == [2,3,4,5,14]
  end
  
  defp n_of_a_kind(hand, n) do
    values = lc {val,_} inlist hand, do: val
    cmap = :euler_helper.count_map(values)
    Enum.any? cmap, fn({_,count}) -> count == n end
  end

  defp pair(hand) do
    n_of_a_kind(hand, 2)
  end
  
  defp three_of_a_kind(hand) do
    n_of_a_kind(hand, 3)
  end

  defp four_of_a_kind(hand) do
    n_of_a_kind(hand, 4)
  end
  
  defp full_house(hand) do
    values = lc {val,_} inlist hand, do: val
    cmap = :euler_helper.count_map(values)
    counts = lc {_,count} inlist cmap, do: count
    Enum.member?(counts, 3) and Enum.member?(counts, 2)
  end

  defp two_pairs(hand) do
    values = lc {val,_} inlist hand, do: val
    cmap = :euler_helper.count_map(values)
    counts = :lists.reverse(:lists.sort(lc {_,count} inlist cmap, do: count))
    hd(counts) == 2 and :lists.nth(2, counts) == 2
  end

  defp hand_better(a,b) do
    testfns = [&royal_flush/1, &straight_flush/1, &four_of_a_kind/1, &full_house/1, &flush/1, &straight/1, &three_of_a_kind/1, &two_pairs/1, &pair/1]
    testresults = lc fnx inlist testfns, do: {apply(fnx,[a]), apply(fnx,[b])}
    search_winner = Enum.find(testresults, fn({ares, bres}) -> ares or bres end)
    case search_winner do
      nil ->
        higher_card_set(a,b)
      {true, true} ->
        higher_card_set(a,b)
      {true, false} ->
        false
      {false, true} ->
        true
    end                                                                                   
  end
    
  defp higher_card_set(a,b) do
    a_values = lc {val,_} inlist a, do: val
    b_values = lc {val,_} inlist b, do: val
    a_count = lc {card,count} inlist :euler_helper.count_map(a_values), do: {:a, card, count}
    b_count = lc {card,count} inlist :euler_helper.count_map(b_values), do: {:b, card, count}
    sorted_counts = Enum.sort(a_count ++ b_count, fn({_ ,carda, counta},{_,cardb, countb}) ->
                                                      if counta == countb do
                                                        not value_better(carda, cardb)
                                                      else
                                                        counta > countb
                                                      end 
                                                  end)
    filtered_counts = Enum.filter(sorted_counts, fn({winner,value,count}) ->
                                                     xmap = [a: :b, b: :a]
                                                     not Enum.member?(sorted_counts,{xmap[winner], value, count})
                                                 end)
    {winner,_,_} = hd(filtered_counts)
    winner == :b
  end

  defp parse_hands(string) do
    cardstrings = String.split(string, " ")
    valuemap = [{"2",:two},{"3",:three},{"4",:four},{"5",:five},{"6",:six},{"7",:seven},{"8",:eight},{"9",:nine},{"T",:ten},{"J",:jack},{"Q",:queen},{"K",:king},{"A",:ace}]
    suitmap = [{"D", :diamonds},{"H",:hearts},{"S",:spades},{"C",:clubs}]
    cards = lc cardstring inlist cardstrings, do: {valuemap[String.slice(cardstring, 0..0)], suitmap[String.slice(cardstring,1..1)]}
    {Enum.slice(cards, 0..4), Enum.slice(cards, 5..9)}
  end

  #tests

  setup do
    {:ok,
     royal_flush: [{:ace, :clubs}, {:king, :clubs}, {:queen, :clubs}, {:jack, :clubs}, {:ten, :clubs}],
     normal_flush: [{:ace, :clubs}, {:two, :clubs}, {:queen, :clubs}, {:jack, :clubs}, {:ten, :clubs}],
     straight_flush: [{:nine, :clubs}, {:king, :clubs}, {:queen, :clubs}, {:jack, :clubs}, {:ten, :clubs}],
     straight: [{:nine, :hearts}, {:eight, :clubs}, {:queen, :clubs}, {:jack, :clubs}, {:ten, :clubs}],
     low_ace_straight: [{:ace, :hearts}, {:two, :clubs}, {:three, :clubs}, {:four, :clubs}, {:five, :clubs}],
     pair: [{:ace, :hearts}, {:ace, :clubs}, {:three, :clubs}, {:four, :clubs}, {:five, :clubs}],
     three: [{:ace, :hearts}, {:ace, :clubs}, {:ace, :diamonds}, {:four, :clubs}, {:five, :clubs}],
     full_house: [{:ace, :hearts}, {:ace, :clubs}, {:ace, :diamonds}, {:four, :clubs}, {:four, :hearts}],
     two_pairs: [{:ace, :hearts}, {:ace, :clubs}, {:two, :diamonds}, {:four, :clubs}, {:four, :hearts}],
     high_king: [{:nine, :hearts}, {:king, :clubs}, {:two, :diamonds}, {:three, :clubs}, {:four, :hearts}],
     high_queen: [{:nine, :hearts}, {:queen, :clubs}, {:two, :diamonds}, {:three, :clubs}, {:four, :hearts}],
     full_house_low: [{:two, :hearts}, {:two, :clubs}, {:three, :diamonds}, {:three, :clubs}, {:three, :hearts}],
     high_card_second_round_low: [{:queen, :hearts}, {:queen, :spades}, {:nine, :hearts}, {:three, :hearts}, {:four, :hearts}],
     high_card_second_round_high: [{:queen, :clubs}, {:queen, :diamonds}, {:three, :hearts}, {:ace, :clubs}, {:four, :clubs}]
    }
  end

  test "card_better" do
    refute card_better({:queen,:spades},{:two,:spades})
    refute card_better({:queen,:clubs},{:queen,:spades})
    assert card_better({:three,:diamonds}, {:ace, :hearts})
  end

  test "suit_better" do
    refute suit_better(:spades, :hearts)
    assert suit_better(:diamonds, :clubs)
  end

  test "value_better" do
    refute value_better(:three, :two)
    refute value_better(:king, :queen)
    assert value_better(:three, :five)
  end

  test "royal_flush", decks do
    assert royal_flush(decks[:royal_flush])
    refute royal_flush(decks[:normal_flush])
  end

  test "flush", decks do
    assert flush(decks[:normal_flush])
    assert flush(decks[:royal_flush])
    assert flush(decks[:straight_flush])
    refute flush(decks[:straight])
  end

  test "straight", decks do
    assert straight(decks[:straight])
    assert straight(decks[:straight_flush])
    assert straight(decks[:royal_flush])
    assert straight(decks[:low_ace_straight])
    refute straight(decks[:normal_flush])
  end

  test "hand_contains", decks do
    assert hand_contains([:ace, :king, :queen], decks[:royal_flush])
    assert hand_contains([:clubs, :clubs, :clubs, :clubs, :clubs], decks[:normal_flush])
    refute hand_contains([:hearts], decks[:normal_flush])
  end

  test "n_of_a_kind", decks do
    assert n_of_a_kind(decks[:pair],2)
    assert n_of_a_kind(decks[:three],3)
    refute n_of_a_kind(decks[:straight],2)
  end

  test "full_house", decks do
    assert full_house(decks[:full_house])
    refute full_house(decks[:straight])
  end

  test "two_pairs", decks do
    assert two_pairs(decks[:two_pairs])
    refute two_pairs(decks[:straight])
  end

  test "hand_better", decks do
    refute hand_better(decks[:royal_flush], decks[:straight])
    refute hand_better(decks[:high_king], decks[:high_queen])
    refute hand_better(decks[:full_house], decks[:full_house_low])
    assert hand_better(decks[:pair], decks[:three])
    {parseda, parsedb} = parse_hands("4D 6S 9H QH QC 3D 6D 7H QD QS")
    assert hand_better(parsedb, parseda)
    refute hand_better(decks[:high_card_second_round_high], decks[:high_card_second_round_low])
    {secondparsed_a, secondparsed_b} = parse_hands("6D 6S 7D 2C 3H 5D 5H JH 2S 7S")
    assert hand_better(secondparsed_b, secondparsed_a)
  end

  test "higher_card_set", decks do
    assert higher_card_set(decks[:full_house_low], decks[:full_house])
    assert higher_card_set(decks[:straight], decks[:royal_flush])
    {parseda, parsedb} = parse_hands("4D 6S 9H QH QC 3D 6D 7H QD QS")
    assert higher_card_set(parsedb, parseda)
   {secondparsed_a, secondparsed_b} = parse_hands("6D 6S 7D 2C 3H 5D 5H JH 2S 7S")
    assert higher_card_set(secondparsed_b, secondparsed_a)
  end

  test "parse_hands" do
    assert parse_hands("8C TS KC 9H 4S 7D 2S 5D 3S AC") == {[eight: :clubs, ten: :spades, king: :clubs, nine: :hearts, four: :spades],[seven: :diamonds, two: :spades, five: :diamonds, three: :spades, ace: :clubs]} 
  end
end
