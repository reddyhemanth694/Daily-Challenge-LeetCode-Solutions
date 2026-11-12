%% Brute Force
%%
%% -spec longest_monotonic_subarray(Nums :: [integer()]) -> integer().
%% longest_monotonic_subarray(Nums) -> brute(Nums, 1).
%%
%% brute([], Res) -> Res;
%% brute([_ | Rest] = L, Res) ->
%%     brute(Rest, lists:max([Res, streak(L, fun(A, B) -> B > A end), streak(L, fun(A, B) -> B < A end)])).
%%
%% streak([A, B | Rest], F) ->
%%     case F(A, B) of
%%         true -> 1 + streak([B | Rest], F);
%%         false -> 1
%%     end;
%% streak(_, _F) -> 1.

%% Better Approach
%%
%% -spec longest_monotonic_subarray(Nums :: [integer()]) -> integer().
%% longest_monotonic_subarray([H | T]) ->
%%     max(pass(T, H, 1, 1, fun(A, B) -> B > A end), pass(T, H, 1, 1, fun(A, B) -> B < A end)).
%%
%% pass([], _Prev, _Len, Res, _F) -> Res;
%% pass([X | T], Prev, Len, Res, F) ->
%%     Len1 = case F(Prev, X) of
%%                true -> Len + 1;
%%                false -> 1
%%            end,
%%     pass(T, X, Len1, max(Res, Len1), F).

-spec longest_monotonic_subarray(Nums :: [integer()]) -> integer().
longest_monotonic_subarray([H | T]) -> go(T, H, 1, 1, 1).

go([], _Prev, _Inc, _Dec, Res) -> Res;
go([X | T], Prev, Inc, Dec, Res) ->
    Inc1 = if X > Prev -> Inc + 1; true -> 1 end,
    Dec1 = if X < Prev -> Dec + 1; true -> 1 end,
    go(T, X, Inc1, Dec1, lists:max([Res, Inc1, Dec1])).