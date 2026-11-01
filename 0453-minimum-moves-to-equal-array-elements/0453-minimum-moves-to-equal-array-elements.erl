%% Brute Force
%%
%% -spec min_moves(Nums :: [integer()]) -> integer().
%% min_moves(Nums) ->
%%     simulate(Nums, 0).
%%
%% simulate(Nums, Moves) ->
%%     Max = lists:max(Nums),
%%     case lists:min(Nums) of
%%         Max -> Moves;
%%         _ -> simulate(bump(Nums, Max), Moves + 1)
%%     end.
%%
%% bump([Max | T], Max) -> [Max | [X + 1 || X <- T]];
%% bump([X | T], Max) -> [X + 1 | bump(T, Max)].

%% Better Approach
%%
%% -spec min_moves(Nums :: [integer()]) -> integer().
%% min_moves(Nums) ->
%%     [H | _] = Sorted = lists:sort(Nums),
%%     lists:foldl(fun(X, Moves) -> Moves + X - H end, 0, Sorted).

-spec min_moves(Nums :: [integer()]) -> integer().
min_moves(Nums) ->
    Min = lists:min(Nums),
    lists:foldl(fun(X, Moves) -> Moves + X - Min end, 0, Nums).