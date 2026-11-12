~S"""
Brute Force

defmodule Solution do
  @spec count_non_decreasing_subarrays(nums :: [integer], k :: integer) :: integer
  def count_non_decreasing_subarrays(nums, k), do: brute(nums, k, 0)

  def brute([], _k, ans), do: ans
  def brute([_ | rest] = list, k, ans), do: brute(rest, k, ans + extend(list, 0, 0, k))

  def extend([], _mx, _cost, _k), do: 0

  def extend([x | rest], mx, cost, k) do
    mx = max(mx, x)
    cost = cost + mx - x
    if cost > k, do: 0, else: 1 + extend(rest, mx, cost, k)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec count_non_decreasing_subarrays(nums :: [integer], k :: integer) :: integer
  def count_non_decreasing_subarrays(nums, k) do
    t = List.to_tuple(nums)
    n = tuple_size(t)
    pre = List.to_tuple([0 | Enum.scan(nums, &(&1 + &2))])
    nxt = List.to_tuple(next_greater(n - 1, t, n, [], []) ++ [n])
    s0 = for(i <- 0..(n - 1), do: elem(t, i) * (elem(nxt, i) - i) - (elem(pre, elem(nxt, i)) - elem(pre, i))) ++ [0]
    levels = build(1, length(Integer.digits(n, 2)), [{nxt, List.to_tuple(s0)}], n)
    Enum.reduce(0..(n - 1), 0, fn l, ans -> ans + count(l, levels, k, t, pre, nxt, n) end)
  end

  def next_greater(i, _t, _n, _st, acc) when i < 0, do: acc

  def next_greater(i, t, n, st, acc) do
    v = elem(t, i)
    st = Enum.drop_while(st, fn j -> elem(t, j) <= v end)
    nx = if st == [], do: n, else: hd(st)
    next_greater(i - 1, t, n, [i | st], [nx | acc])
  end

  def build(j, lg, acc, _n) when j >= lg, do: acc

  def build(j, lg, [{u, s} | _] = acc, n) do
    u1 = List.to_tuple(for i <- 0..n, do: elem(u, elem(u, i)))
    s1 = List.to_tuple(for i <- 0..n, do: elem(s, i) + elem(s, elem(u, i)))
    build(j + 1, lg, [{u1, s1} | acc], n)
  end

  def count(l, levels, k, t, pre, nxt, n) do
    {cur, acc} = jump(levels, l, 0, k, n)
    if cur == n, do: n - l, else: search(cur, elem(nxt, cur) - 1, cur, acc, k, t, pre) - l + 1
  end

  def jump([{u, s} | rest], cur, acc, k, n) when cur < n do
    add = elem(s, cur)
    if acc + add <= k, do: jump(rest, elem(u, cur), acc + add, k, n), else: jump(rest, cur, acc, k, n)
  end

  def jump(_, cur, acc, _k, _n), do: {cur, acc}

  def search(lo, hi, _cur, _acc, _k, _t, _pre) when lo >= hi, do: lo

  def search(lo, hi, cur, acc, k, t, pre) do
    mid = div(lo + hi + 1, 2)
    cost = acc + elem(t, cur) * (mid - cur + 1) - (elem(pre, mid + 1) - elem(pre, cur))
    if cost <= k, do: search(mid, hi, cur, acc, k, t, pre), else: search(lo, mid - 1, cur, acc, k, t, pre)
  end
end
"""

defmodule Solution do
  @spec count_non_decreasing_subarrays(nums :: [integer], k :: integer) :: integer
  def count_non_decreasing_subarrays(nums, k) do
    t = List.to_tuple(nums)
    n = tuple_size(t)
    go(n - 1, n - 1, :queue.new(), 0, 0, k, t)
  end

  def go(l, _r, _q, _cost, ans, _k, _t) when l < 0, do: ans

  def go(l, r, q, cost, ans, k, t) do
    {q, cost} = absorb(q, elem(t, l), r, cost, t)
    {r, q, cost} = shrink(r, :queue.in_r(l, q), cost, k, t)
    go(l - 1, r, q, cost, ans + r - l + 1, k, t)
  end

  def absorb(q, v, r, cost, t) do
    case :queue.peek(q) do
      {:value, i} when elem(t, i) <= v ->
        q = :queue.drop(q)

        stop =
          case :queue.peek(q) do
            {:value, j} -> j
            :empty -> r + 1
          end

        absorb(q, v, r, cost + (v - elem(t, i)) * (stop - i), t)

      _ ->
        {q, cost}
    end
  end

  def shrink(r, q, cost, k, _t) when cost <= k, do: {r, q, cost}

  def shrink(r, q, cost, k, t) do
    {:value, b} = :queue.peek_r(q)
    q = if b == r, do: :queue.drop_r(q), else: q
    shrink(r - 1, q, cost - (elem(t, b) - elem(t, r)), k, t)
  end
end