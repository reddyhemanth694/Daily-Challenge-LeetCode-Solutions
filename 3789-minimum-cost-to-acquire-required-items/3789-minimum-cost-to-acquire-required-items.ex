~S"""
Brute Force

defmodule Solution do
  @spec minimum_cost(cost1 :: integer, cost2 :: integer, cost_both :: integer, need1 :: integer, need2 :: integer) :: integer
  def minimum_cost(cost1, cost2, cost_both, need1, need2) do
    0..max(need1, need2)
    |> Enum.map(fn k -> k * cost_both + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2 end)
    |> Enum.min()
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec minimum_cost(cost1 :: integer, cost2 :: integer, cost_both :: integer, need1 :: integer, need2 :: integer) :: integer
  def minimum_cost(cost1, cost2, cost_both, need1, need2) do
    total = fn k -> k * cost_both + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2 end
    search(total, 0, max(need1, need2))
  end

  def search(total, lo, hi) when lo >= hi, do: total.(lo)

  def search(total, lo, hi) do
    mid = div(lo + hi, 2)
    if total.(mid) <= total.(mid + 1), do: search(total, lo, mid), else: search(total, mid + 1, hi)
  end
end
"""

defmodule Solution do
  @spec minimum_cost(cost1 :: integer, cost2 :: integer, cost_both :: integer, need1 :: integer, need2 :: integer) :: integer
  def minimum_cost(cost1, cost2, cost_both, need1, need2) do
    both = min(need1, need2)
    both * min(cost_both, cost1 + cost2) + (need1 - both) * min(cost1, cost_both) + (need2 - both) * min(cost2, cost_both)
  end
end