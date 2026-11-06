~S"""
Brute Force

defmodule Solution do
  @spec count_servers(n :: integer, logs :: [[integer]], x :: integer, queries :: [integer]) :: [integer]
  def count_servers(n, logs, x, queries) do
    Enum.map(queries, fn q ->
      active =
        logs
        |> Enum.filter(fn [_, t] -> t >= q - x and t <= q end)
        |> Enum.uniq_by(fn [s, _] -> s end)

      n - length(active)
    end)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec count_servers(n :: integer, logs :: [[integer]], x :: integer, queries :: [integer]) :: [integer]
  def count_servers(n, logs, x, queries) do
    sorted = logs |> Enum.map(fn [s, t] -> {t, s} end) |> Enum.sort() |> List.to_tuple()
    m = tuple_size(sorted)
    Enum.map(queries, fn q -> n - count(sorted, lower_bound(sorted, q - x, 0, m), m, q, MapSet.new()) end)
  end

  def lower_bound(_t, _v, lo, hi) when lo >= hi, do: lo

  def lower_bound(t, v, lo, hi) do
    mid = div(lo + hi, 2)
    if elem(elem(t, mid), 0) < v, do: lower_bound(t, v, mid + 1, hi), else: lower_bound(t, v, lo, mid)
  end

  def count(_t, j, m, _q, seen) when j >= m, do: MapSet.size(seen)

  def count(t, j, m, q, seen) do
    case elem(t, j) do
      {time, s} when time <= q -> count(t, j + 1, m, q, MapSet.put(seen, s))
      _ -> MapSet.size(seen)
    end
  end
end
"""

defmodule Solution do
  import Bitwise

  @spec count_servers(n :: integer, logs :: [[integer]], x :: integer, queries :: [integer]) :: [integer]
  def count_servers(n, logs, x, queries) do
    sorted = logs |> Enum.map(fn [s, t] -> (t <<< 17) ||| s end) |> Enum.sort()
    qs = queries |> keys(0, []) |> Enum.sort()
    k = length(queries)
    cnt = :atomics.new(n, [])
    ans = :atomics.new(k, [])
    go(qs, sorted, sorted, 0, n, x, cnt, ans)
    for i <- 1..k, do: :atomics.get(ans, i)
  end

  def keys([], _i, acc), do: acc
  def keys([q | qs], i, acc), do: keys(qs, i + 1, [(q <<< 17) ||| i | acc])

  def go([], _ahead, _behind, _d, _n, _x, _cnt, _ans), do: :ok

  def go([key | ks], ahead, behind, d, n, x, cnt, ans) do
    q = key >>> 17
    {ahead, d} = add(ahead, q, cnt, d)
    {behind, d} = remove(behind, q - x, cnt, d)
    :atomics.put(ans, (key &&& 131_071) + 1, n - d)
    go(ks, ahead, behind, d, n, x, cnt, ans)
  end

  def add([key | rest], q, cnt, d) when key >>> 17 <= q do
    if :atomics.add_get(cnt, key &&& 131_071, 1) == 1, do: add(rest, q, cnt, d + 1), else: add(rest, q, cnt, d)
  end

  def add(list, _q, _cnt, d), do: {list, d}

  def remove([key | rest], lo, cnt, d) when key >>> 17 < lo do
    if :atomics.sub_get(cnt, key &&& 131_071, 1) == 0, do: remove(rest, lo, cnt, d - 1), else: remove(rest, lo, cnt, d)
  end

  def remove(list, _lo, _cnt, d), do: {list, d}
end