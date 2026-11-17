~S"""
Brute Force

defmodule Solution do
  @spec min_changes(s :: String.t()) :: integer
  def min_changes(s), do: solve(String.to_charlist(s))

  def solve([]), do: 0

  def solve(list) do
    2..length(list)//2
    |> Enum.map(fn len ->
      {block, rest} = Enum.split(list, len)
      ones = Enum.count(block, &(&1 == ?1))
      min(ones, len - ones) + solve(rest)
    end)
    |> Enum.min()
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec min_changes(s :: String.t()) :: integer
  def min_changes(s) do
    n = byte_size(s)
    bits = s |> String.to_charlist() |> Enum.map(&(&1 - ?0)) |> List.to_tuple()

    dp =
      Enum.reduce(0..(n - 2)//2, %{0 => 0}, fn i, dp ->
        base = dp[i]

        {_, dp} =
          Enum.reduce(i..(n - 1), {0, dp}, fn j, {ones, dp} ->
            ones = ones + elem(bits, j)
            len = j - i + 1

            if rem(len, 2) == 0 do
              cost = base + min(ones, len - ones)
              {ones, Map.update(dp, j + 1, cost, &min(&1, cost))}
            else
              {ones, dp}
            end
          end)

        dp
      end)

    dp[n]
  end
end
"""

defmodule Solution do
  @spec min_changes(s :: String.t()) :: integer
  def min_changes(s), do: count(s, 0)

  def count(<<a, b, rest::binary>>, acc), do: count(rest, if(a == b, do: acc, else: acc + 1))
  def count(<<>>, acc), do: acc
end