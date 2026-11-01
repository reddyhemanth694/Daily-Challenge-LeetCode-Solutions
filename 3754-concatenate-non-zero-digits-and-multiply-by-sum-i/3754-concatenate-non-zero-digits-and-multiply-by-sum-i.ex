~S"""
Brute Force

defmodule Solution do
  @spec sum_and_multiply(n :: integer) :: integer
  def sum_and_multiply(n) do
    case n |> Integer.to_string() |> String.replace("0", "") do
      "" -> 0
      t -> String.to_integer(t) * (t |> String.to_charlist() |> Enum.map(&(&1 - ?0)) |> Enum.sum())
    end
  end
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec sum_and_multiply(n :: integer) :: integer
  def sum_and_multiply(n) do
    {x, sum} =
      n
      |> Integer.digits()
      |> Enum.reduce({0, 0}, fn
        0, acc -> acc
        d, {x, sum} -> {x * 10 + d, sum + d}
      end)

    x * sum
  end
end
"""

defmodule Solution do
  @spec sum_and_multiply(n :: integer) :: integer
  def sum_and_multiply(n), do: walk(n, 0, 0, 1)

  def walk(0, x, sum, _p), do: x * sum

  def walk(n, x, sum, p) do
    case rem(n, 10) do
      0 -> walk(div(n, 10), x, sum, p)
      d -> walk(div(n, 10), x + d * p, sum + d, p * 10)
    end
  end
end