defmodule Solution do
  def find_min_arrow_shots(points) do
    sorted = Enum.sort_by(points, fn p -> Enum.at(p, 1) end)

    [{_, arrow}] = [hd(sorted) |> then(fn p -> {p, Enum.at(p, 1)} end)]

    sorted
    |> tl()
    |> Enum.reduce({1, arrow}, fn point, {arrows, arrow} ->
      if Enum.at(point, 0) > arrow do
        {arrows + 1, Enum.at(point, 1)}
      else
        {arrows, arrow}
      end
    end)
    |> elem(0)
  end
end