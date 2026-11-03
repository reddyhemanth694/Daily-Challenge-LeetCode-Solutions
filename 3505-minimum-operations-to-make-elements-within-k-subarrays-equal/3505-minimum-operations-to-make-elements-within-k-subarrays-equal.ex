~S"""
Brute Force

defmodule Solution do
  @spec min_operations(nums :: [integer], x :: integer, k :: integer) :: integer
  def min_operations(nums, x, k) do
    arr = List.to_tuple(nums)
    dfs(arr, tuple_size(arr), x, 0, k)
  end

  def dfs(_arr, _n, _x, _i, 0), do: 0
  def dfs(_arr, n, x, i, j) when n - i < j * x, do: :infinity

  def dfs(arr, n, x, i, j) do
    min(dfs(arr, n, x, i + 1, j), window_cost(arr, x, i) + dfs(arr, n, x, i + x, j - 1))
  end

  def window_cost(arr, x, i) do
    w = Enum.sort(for t <- i..(i + x - 1), do: elem(arr, t))
    med = Enum.at(w, div(x, 2))
    Enum.reduce(w, 0, fn v, acc -> acc + abs(v - med) end)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  import Bitwise

  @spec min_operations(nums :: [integer], x :: integer, k :: integer) :: integer
  def min_operations(nums, x, k) do
    arr = List.to_tuple(nums)
    n = tuple_size(arr)

    cost =
      for i <- 0..(n - x) do
        w = Enum.sort(for t <- i..(i + x - 1), do: elem(arr, t))
        med = Enum.at(w, div(x, 2))
        Enum.reduce(w, 0, fn v, acc -> acc + abs(v - med) end)
      end

    dp(k, n, x, List.to_tuple(cost), Tuple.duplicate(0, n + 1))
  end

  def dp(0, _n, _x, _cost, prev), do: elem(prev, tuple_size(prev) - 1)

  def dp(j, n, x, cost, prev) do
    dp(j - 1, n, x, cost, List.to_tuple(row(0, n, x, cost, prev, 1 <<< 62, [])))
  end

  def row(i, n, _x, _cost, _prev, _last, acc) when i > n, do: Enum.reverse(acc)
  def row(i, n, x, cost, prev, last, acc) when i < x, do: row(i + 1, n, x, cost, prev, last, [last | acc])

  def row(i, n, x, cost, prev, last, acc) do
    v = min(last, elem(prev, i - x) + elem(cost, i - x))
    row(i + 1, n, x, cost, prev, v, [v | acc])
  end
end
"""

defmodule Solution do
  import Bitwise

  @spec min_operations(nums :: [integer], x :: integer, k :: integer) :: integer
  def min_operations(nums, x, k) do
    n = length(nums)
    keys = nums |> keys(0, []) |> Enum.sort()
    rank_a = :atomics.new(n, [])
    val_t = keys |> ranks(0, rank_a, []) |> List.to_tuple()
    ranks = for i <- 1..n, do: :atomics.get(rank_a, i)
    lv = n |> levels([]) |> List.to_tuple()
    half = div(x + 1, 2)
    {first_r, ahead_r} = Enum.split(ranks, x)
    {first_n, ahead_n} = Enum.split(nums, x)
    Enum.each(first_r, fn r -> ins(r, 1, lv) end)
    sorted = Enum.sort(first_r)
    sum_l = sorted |> Enum.take(half) |> Enum.reduce(0, fn r, acc -> acc + elem(val_t, r) end)
    ml = Enum.at(sorted, half - 1)
    total = Enum.sum(first_n)
    c0 = total - 2 * sum_l + elem(val_t, ml) * (2 * half - x)
    cost = win(ahead_n, ahead_r, nums, ranks, ml, sum_l, total, half, x, val_t, lv, [c0])
    dp(k, x, cost, List.duplicate(0, n + 1))
  end

  def keys([], _i, acc), do: acc
  def keys([v | vs], i, acc), do: keys(vs, i + 1, [((v + 1_000_000) <<< 17) + i | acc])

  def ranks([], _r, _rank_a, acc), do: Enum.reverse(acc)

  def ranks([key | ks], r, rank_a, acc) do
    :atomics.put(rank_a, (key &&& 131_071) + 1, r)
    ranks(ks, r + 1, rank_a, [(key >>> 17) - 1_000_000 | acc])
  end

  def levels(size, acc) do
    w = (size + 31) >>> 5
    acc = [:atomics.new(w, []) | acc]
    if w == 1, do: Enum.reverse(acc), else: levels(w, acc)
  end

  def ins(r, l, lv) do
    bit = 1 <<< (r &&& 31)
    w = r >>> 5

    if :atomics.add_get(elem(lv, l - 1), w + 1, bit) == bit and l < tuple_size(lv) do
      ins(w, l + 1, lv)
    end
  end

  def del(r, l, lv) do
    w = r >>> 5

    if :atomics.sub_get(elem(lv, l - 1), w + 1, 1 <<< (r &&& 31)) == 0 and l < tuple_size(lv) do
      del(w, l + 1, lv)
    end
  end

  def nxt(r, l, lv) do
    w = r >>> 5

    case :atomics.get(elem(lv, l - 1), w + 1) >>> ((r &&& 31) + 1) do
      0 -> nxt(w, l + 1, lv)
      m -> down_low(r + 1 + low(m), l, lv)
    end
  end

  def down_low(r, 1, _lv), do: r
  def down_low(r, l, lv), do: down_low((r <<< 5) + low(:atomics.get(elem(lv, l - 2), r + 1)), l - 1, lv)

  def prv(r, l, lv) do
    w = r >>> 5

    case :atomics.get(elem(lv, l - 1), w + 1) &&& (1 <<< (r &&& 31)) - 1 do
      0 -> prv(w, l + 1, lv)
      m -> down_high((w <<< 5) + high(m), l, lv)
    end
  end

  def down_high(r, 1, _lv), do: r
  def down_high(r, l, lv), do: down_high((r <<< 5) + high(:atomics.get(elem(lv, l - 2), r + 1)), l - 1, lv)

  def low(m), do: high(m &&& -m)

  def high(m), do: trunc(:math.log2(m))

  def win([], _, _, _, _, _, _, _, _, _, _, acc), do: Enum.reverse(acc)

  def win([a | ta], [ra | tra], [b | tb], [rb | trb], ml, sum_l, total, half, x, val_t, lv, acc) do
    ins(ra, 1, lv)

    {ml, sum_l} =
      if ra < ml, do: {prv(ml, 1, lv), sum_l + a - elem(val_t, ml)}, else: {ml, sum_l}

    del(rb, 1, lv)

    {ml, sum_l} =
      if rb <= ml do
        q = nxt(ml, 1, lv)
        {q, sum_l - b + elem(val_t, q)}
      else
        {ml, sum_l}
      end

    total = total + a - b
    c = total - 2 * sum_l + elem(val_t, ml) * (2 * half - x)
    win(ta, tra, tb, trb, ml, sum_l, total, half, x, val_t, lv, [c | acc])
  end

  def dp(0, _x, _cost, prev), do: List.last(prev)

  def dp(j, x, cost, prev) do
    dp(j - 1, x, cost, List.duplicate(1 <<< 58, x) ++ row(prev, cost, 1 <<< 58, []))
  end

  def row(_, [], _last, acc), do: Enum.reverse(acc)

  def row([p | ps], [c | cs], last, acc) do
    v = min(last, p + c)
    row(ps, cs, v, [v | acc])
  end
end