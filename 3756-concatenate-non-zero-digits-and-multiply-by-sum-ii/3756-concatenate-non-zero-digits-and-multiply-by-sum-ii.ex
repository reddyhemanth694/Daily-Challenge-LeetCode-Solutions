~S"""
Brute Force

defmodule Solution do
  @spec sum_and_multiply(s :: String.t, queries :: [[integer]]) :: [integer]
  def sum_and_multiply(s, queries) do
    Enum.map(queries, fn [l, r] ->
      {x, sum} =
        s
        |> :binary.part(l, r - l + 1)
        |> :binary.bin_to_list()
        |> Enum.reduce({0, 0}, fn
          ?0, acc -> acc
          c, {x, sum} -> {rem(x * 10 + c - ?0, 1_000_000_007), sum + c - ?0}
        end)

      rem(x * sum, 1_000_000_007)
    end)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec sum_and_multiply(s :: String.t, queries :: [[integer]]) :: [integer]
  def sum_and_multiply(s, queries) do
    m = 1_000_000_007

    {pre, cnt, sum} =
      s
      |> :binary.bin_to_list()
      |> Enum.reduce({[0], [0], [0]}, fn c, {[p | _] = ps, [k | _] = ks, [t | _] = ts} ->
        case c - ?0 do
          0 -> {[p | ps], [k | ks], [t | ts]}
          d -> {[rem(p * 10 + d, m) | ps], [k + 1 | ks], [t + d | ts]}
        end
      end)

    [pre, cnt, sum] = Enum.map([pre, cnt, sum], &(&1 |> Enum.reverse() |> List.to_tuple()))

    Enum.map(queries, fn [l, r] ->
      k = elem(cnt, r + 1) - elem(cnt, l)
      x = Integer.mod(elem(pre, r + 1) - elem(pre, l) * power(10, k, m), m)
      rem(x * (elem(sum, r + 1) - elem(sum, l)), m)
    end)
  end

  def power(_b, 0, _m), do: 1
  def power(b, e, m) when rem(e, 2) == 0, do: power(rem(b * b, m), div(e, 2), m)
  def power(b, e, m), do: rem(b * power(b, e - 1, m), m)
end
"""

defmodule Solution do
  @spec sum_and_multiply(s :: String.t, queries :: [[integer]]) :: [integer]
  def sum_and_multiply(s, queries) do
    m = 1_000_000_007

    {pre, cnt, sum, pw} =
      s
      |> :binary.bin_to_list()
      |> Enum.reduce({[0], [0], [0], [1]}, fn c, {[p | _] = ps, [k | _] = ks, [t | _] = ts, [w | _] = ws} ->
        case c - ?0 do
          0 -> {[p | ps], [k | ks], [t | ts], [rem(w * 10, m) | ws]}
          d -> {[rem(p * 10 + d, m) | ps], [k + 1 | ks], [t + d | ts], [rem(w * 10, m) | ws]}
        end
      end)

    [pre, cnt, sum, pw] = Enum.map([pre, cnt, sum, pw], &(&1 |> Enum.reverse() |> List.to_tuple()))

    Enum.map(queries, fn [l, r] ->
      k = elem(cnt, r + 1) - elem(cnt, l)
      x = Integer.mod(elem(pre, r + 1) - elem(pre, l) * elem(pw, k), m)
      rem(x * (elem(sum, r + 1) - elem(sum, l)), m)
    end)
  end
end