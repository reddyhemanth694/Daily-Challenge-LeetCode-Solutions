~S"""
Brute Force

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums), do: simulate(nums, 0)

  def simulate(nums, moves) do
    mx = Enum.max(nums)

    if Enum.min(nums) == mx do
      moves
    else
      simulate(bump(nums, mx), moves + 1)
    end
  end

  def bump([mx | rest], mx), do: [mx | Enum.map(rest, &(&1 + 1))]
  def bump([x | rest], mx), do: [x + 1 | bump(rest, mx)]
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums) do
    [h | _] = sorted = Enum.sort(nums)
    Enum.reduce(sorted, 0, fn x, moves -> moves + x - h end)
  end
end
"""

defmodule Solution do
  @spec min_moves(nums :: [integer]) :: integer
  def min_moves(nums) do
    mn = Enum.min(nums)
    Enum.reduce(nums, 0, fn x, moves -> moves + x - mn end)
  end
end