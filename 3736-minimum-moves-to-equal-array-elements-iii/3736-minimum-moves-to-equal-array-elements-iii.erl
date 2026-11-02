%% Brute Force
%%
%% -spec min_moves(Nums :: [integer()]) -> integer().
%% min_moves(Nums) ->
%%     simulate(Nums, 0).
%%
%% simulate(Nums, Moves) ->
%%     Min = lists:min(Nums),
%%     case lists:max(Nums) of
%%         Min -> Moves;
%%         _ -> simulate(bump(Nums, Min), Moves + 1)
%%     end.
%%
%% bump([Min | T], Min) -> [Min + 1 | T];
%% bump([X | T], Min) -> [X | bump(T, Min)].

%% Better Approach
%%
%% -spec min_moves(Nums :: [integer()]) -> integer().
%% min_moves(Nums) ->
%%     Sorted = lists:sort(Nums),
%%     Last = lists:last(Sorted),
%%     lists:foldl(fun(X, Moves) -> Moves + Last - X end, 0, Sorted).

-spec min_moves(Nums :: [integer()]) -> integer().
min_moves(Nums) ->
    {Max, Sum, N} = lists:foldl(fun(X, {M, S, C}) -> {max(M, X), S + X, C + 1} end, {0, 0, 0}, Nums),
    Max * N - Sum.