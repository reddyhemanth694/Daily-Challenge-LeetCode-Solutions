# Brute Force
# defmodule Solution do
#   @spec count_servers(grid :: [[integer]]) :: integer
#   def count_servers(grid) do
#     m = length(grid)
#     n = length(hd(grid))
#     at = fn i, j -> grid |> Enum.at(i) |> Enum.at(j) end
#     length(
#       for i <- 0..(m - 1), j <- 0..(n - 1),
#           at.(i, j) == 1,
#           Enum.any?(0..(n - 1), fn k -> k != j and at.(i, k) == 1 end) or
#             Enum.any?(0..(m - 1), fn k -> k != i and at.(k, j) == 1 end),
#           do: 1
#     )
#   end
# end

# Better Approach
# defmodule Solution do
#   @spec count_servers(grid :: [[integer]]) :: integer
#   def count_servers(grid) do
#     rows = Enum.map(grid, &Enum.sum/1)
#     cols = grid |> Enum.zip() |> Enum.map(fn t -> t |> Tuple.to_list() |> Enum.sum() end)
#     grid
#     |> Enum.zip(rows)
#     |> Enum.map(fn {row, rs} ->
#       row |> Enum.zip(cols) |> Enum.count(fn {v, cs} -> v == 1 and (rs > 1 or cs > 1) end)
#     end)
#     |> Enum.sum()
#   end
# end

# Optimized Approach: answer = total - isolated (isolated = alone in row and column)
defmodule Solution do
  @spec count_servers(grid :: [[integer]]) :: integer
  def count_servers(grid) do
    rows = Enum.map(grid, &Enum.sum/1)

    cols =
      grid
      |> Enum.zip()
      |> Enum.map(fn t -> t |> Tuple.to_list() |> Enum.sum() end)

    isolated =
      grid
      |> Enum.zip(rows)
      |> Enum.map(fn {row, rs} ->
        if rs == 1 do
          row |> Enum.zip(cols) |> Enum.count(fn {v, cs} -> v == 1 and cs == 1 end)
        else
          0
        end
      end)
      |> Enum.sum()

    Enum.sum(rows) - isolated
  end
end