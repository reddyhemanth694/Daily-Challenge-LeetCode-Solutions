%% Brute Force
%%
%% -spec min_moves2(Nums :: [integer()]) -> integer().
%% min_moves2(Nums) ->
%%     lists:min([lists:sum([abs(A - X) || A <- Nums]) || X <- Nums]).

%% Better Approach
%%
%% -spec min_moves2(Nums :: [integer()]) -> integer().
%% min_moves2(Nums) ->
%%     Median = lists:nth(length(Nums) div 2 + 1, lists:sort(Nums)),
%%     lists:foldl(fun(A, Acc) -> Acc + abs(A - Median) end, 0, Nums).

-spec min_moves2(Nums :: [integer()]) -> integer().
min_moves2(Nums) ->
    Median = select(Nums, length(Nums) div 2),
    lists:foldl(fun(A, Acc) -> Acc + abs(A - Median) end, 0, Nums).

select(List, K) ->
    Pivot = lists:nth(rand:uniform(length(List)), List),
    {Less, Equal, Greater} = split(List, Pivot, [], 0, []),
    N = length(Less),
    if
        K < N -> select(Less, K);
        K < N + Equal -> Pivot;
        true -> select(Greater, K - N - Equal)
    end.

split([], _P, Less, Equal, Greater) -> {Less, Equal, Greater};
split([X | T], P, Less, Equal, Greater) when X < P -> split(T, P, [X | Less], Equal, Greater);
split([X | T], P, Less, Equal, Greater) when X > P -> split(T, P, Less, Equal, [X | Greater]);
split([_ | T], P, Less, Equal, Greater) -> split(T, P, Less, Equal + 1, Greater).