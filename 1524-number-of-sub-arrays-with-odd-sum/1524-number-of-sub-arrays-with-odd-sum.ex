~S"""
Brute Force

defmodule Solution do
  @spec num_of_subarrays(arr :: [integer]) :: integer
  def num_of_subarrays(arr) do
    n = length(arr)

    count =
      for i <- 0..(n - 1),
          j <- i..(n - 1),
          rem(arr |> Enum.slice(i..j) |> Enum.sum(), 2) == 1,
          reduce: 0 do
        acc -> acc + 1
      end

    rem(count, 1_000_000_007)
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec num_of_subarrays(arr :: [integer]) :: integer
  def num_of_subarrays(arr), do: rem(better(arr, 0), 1_000_000_007)

  def better([], acc), do: acc

  def better([_ | rest] = list, acc) do
    {_, count} =
      Enum.reduce(list, {0, acc}, fn x, {sum, c} ->
        sum = sum + x
        if rem(sum, 2) == 1, do: {sum, c + 1}, else: {sum, c}
      end)

    better(rest, count)
  end
end
"""

defmodule Solution do
  @spec num_of_subarrays(arr :: [integer]) :: integer
  def num_of_subarrays(arr) do
    {_, _, _, ans} =
      Enum.reduce(arr, {0, 1, 0, 0}, fn x, {odd, even, sum, ans} ->
        sum = sum + x

        if rem(sum, 2) == 1,
          do: {odd + 1, even, sum, rem(ans + even, 1_000_000_007)},
          else: {odd, even + 1, sum, rem(ans + odd, 1_000_000_007)}
      end)

    ans
  end
end