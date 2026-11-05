~S"""
Brute Force

defmodule Solution do
  @spec find_the_distance_value(arr1 :: [integer], arr2 :: [integer], d :: integer) :: integer
  def find_the_distance_value(arr1, arr2, d) do
    Enum.count(arr1, fn a -> Enum.all?(arr2, fn b -> abs(a - b) > d end) end)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec find_the_distance_value(arr1 :: [integer], arr2 :: [integer], d :: integer) :: integer
  def find_the_distance_value(arr1, arr2, d) do
    t = arr2 |> Enum.sort() |> List.to_tuple()
    m = tuple_size(t)

    Enum.count(arr1, fn a ->
      i = lower_bound(t, a - d, 0, m)
      i == m or elem(t, i) > a + d
    end)
  end

  def lower_bound(_t, _x, lo, hi) when lo >= hi, do: lo

  def lower_bound(t, x, lo, hi) do
    mid = div(lo + hi, 2)
    if elem(t, mid) < x, do: lower_bound(t, x, mid + 1, hi), else: lower_bound(t, x, lo, mid)
  end
end
"""

defmodule Solution do
  @spec find_the_distance_value(arr1 :: [integer], arr2 :: [integer], d :: integer) :: integer
  def find_the_distance_value(arr1, arr2, d) do
    freq = Enum.frequencies(arr2)
    pre = List.to_tuple([0 | Enum.scan(-1100..1100, 0, fn v, acc -> acc + Map.get(freq, v, 0) end)])
    Enum.count(arr1, fn a -> elem(pre, a + d + 1101) == elem(pre, a - d + 1100) end)
  end
end