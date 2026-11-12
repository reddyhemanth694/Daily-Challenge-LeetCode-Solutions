~S"""
Brute Force

defmodule Solution do
  @spec longest_monotonic_subarray(nums :: [integer]) :: integer
  def longest_monotonic_subarray(nums), do: brute(nums, 1)

  def brute([], res), do: res

  def brute([_ | rest] = list, res) do
    brute(rest, Enum.max([res, run(list, &>/2), run(list, &</2)]))
  end

  def run([a, b | rest], cmp) do
    if cmp.(b, a), do: 1 + run([b | rest], cmp), else: 1
  end

  def run(_, _cmp), do: 1
end
"""

~S"""
Better Approach

defmodule Solution do
  @spec longest_monotonic_subarray(nums :: [integer]) :: integer
  def longest_monotonic_subarray([h | t]) do
    max(pass(t, h, 1, 1, &>/2), pass(t, h, 1, 1, &</2))
  end

  def pass([], _prev, _len, res, _cmp), do: res

  def pass([x | t], prev, len, res, cmp) do
    len = if cmp.(x, prev), do: len + 1, else: 1
    pass(t, x, len, max(res, len), cmp)
  end
end
"""

defmodule Solution do
  @spec longest_monotonic_subarray(nums :: [integer]) :: integer
  def longest_monotonic_subarray([h | t]), do: go(t, h, 1, 1, 1)

  def go([], _prev, _inc, _dec, res), do: res

  def go([x | t], prev, inc, dec, res) do
    inc = if x > prev, do: inc + 1, else: 1
    dec = if x < prev, do: dec + 1, else: 1
    go(t, x, inc, dec, Enum.max([res, inc, dec]))
  end
end