~S"""
Brute Force

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums), do: simulate(nums, 0)

  def simulate(nums, moves) do
    mn = Enum.min(nums)

    if Enum.max(nums) == mn do
      moves
    else
      simulate(bump(nums, mn), moves + 1)
    end
  end

  def bump([mn | rest], mn), do: [mn + 1 | rest]
  def bump([x | rest], mn), do: [x | bump(rest, mn)]
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums) do
    sorted = Enum.sort(nums)
    last = List.last(sorted)
    Enum.reduce(sorted, 0, fn x, moves -> moves + last - x end)
  end
end
"""

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums) do
    {mx, sum, n} = Enum.reduce(nums, {0, 0, 0}, fn x, {mx, sum, n} -> {max(mx, x), sum + x, n + 1} end)
    mx * n - sum
  end
end