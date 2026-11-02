~S"""
Brute Force

defmodule Solution do
  @spec min_moves2(nums :: [integer]) :: integer
  def min_moves2(nums) do
    nums
    |> Enum.map(fn x -> Enum.reduce(nums, 0, fn a, acc -> acc + abs(a - x) end) end)
    |> Enum.min()
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec min_moves2(nums :: [integer]) :: integer
  def min_moves2(nums) do
    median = nums |> Enum.sort() |> Enum.at(div(length(nums), 2))
    Enum.reduce(nums, 0, fn a, acc -> acc + abs(a - median) end)
  end
end
"""

defmodule Solution do
  @spec min_moves2(nums :: [integer]) :: integer
  def min_moves2(nums) do
    median = select(nums, div(length(nums), 2))
    Enum.reduce(nums, 0, fn a, acc -> acc + abs(a - median) end)
  end

  def select(list, k) do
    pivot = Enum.random(list)
    {less, equal, greater} = split(list, pivot, [], 0, [])
    n = length(less)

    cond do
      k < n -> select(less, k)
      k < n + equal -> pivot
      true -> select(greater, k - n - equal)
    end
  end

  def split([], _p, less, equal, greater), do: {less, equal, greater}
  def split([x | t], p, less, equal, greater) when x < p, do: split(t, p, [x | less], equal, greater)
  def split([x | t], p, less, equal, greater) when x > p, do: split(t, p, less, equal, [x | greater])
  def split([_ | t], p, less, equal, greater), do: split(t, p, less, equal + 1, greater)
end