-spec find_min_arrow_shots(Points :: [[integer()]]) -> integer().

find_min_arrow_shots(Points) ->
    Sorted = lists:sort(
        fun(A, B) ->
            lists:nth(2, A) < lists:nth(2, B)
        end,
        Points
    ),

    [First | Rest] = Sorted,
    Arrow = lists:nth(2, First),

    {Arrows, _} = lists:foldl(
        fun(Point, {Count, CurrentArrow}) ->
            Start = lists:nth(1, Point),
            End = lists:nth(2, Point),

            case Start > CurrentArrow of
                true -> {Count + 1, End};
                false -> {Count, CurrentArrow}
            end
        end,
        {1, Arrow},
        Rest
    ),

    Arrows.