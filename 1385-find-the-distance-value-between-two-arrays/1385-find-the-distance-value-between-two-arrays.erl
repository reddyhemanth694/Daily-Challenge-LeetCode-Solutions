%% Brute Force
%%
%% -spec find_the_distance_value(Arr1 :: [integer()], Arr2 :: [integer()], D :: integer()) -> integer().
%% find_the_distance_value(Arr1, Arr2, D) ->
%%     length([A || A <- Arr1, lists:all(fun(B) -> abs(A - B) > D end, Arr2)]).

%% Better Approach
%%
%% -spec find_the_distance_value(Arr1 :: [integer()], Arr2 :: [integer()], D :: integer()) -> integer().
%% find_the_distance_value(Arr1, Arr2, D) ->
%%     T = list_to_tuple(lists:sort(Arr2)),
%%     M = tuple_size(T),
%%     length([A || A <- Arr1, far(T, M, lower_bound(T, A - D, 1, M + 1), A + D)]).
%%
%% lower_bound(_T, _X, Lo, Hi) when Lo >= Hi -> Lo;
%% lower_bound(T, X, Lo, Hi) ->
%%     Mid = (Lo + Hi) div 2,
%%     case element(Mid, T) < X of
%%         true -> lower_bound(T, X, Mid + 1, Hi);
%%         false -> lower_bound(T, X, Lo, Mid)
%%     end.
%%
%% far(_T, M, I, _Hi) when I > M -> true;
%% far(T, _M, I, Hi) -> element(I, T) > Hi.

-spec find_the_distance_value(Arr1 :: [integer()], Arr2 :: [integer()], D :: integer()) -> integer().
find_the_distance_value(Arr1, Arr2, D) ->
    Cnt = lists:foldl(fun(V, Acc) -> maps:update_with(V, fun(C) -> C + 1 end, 1, Acc) end, #{}, Arr2),
    {_, Pre} = lists:foldl(fun(V, {S, L}) -> S1 = S + maps:get(V, Cnt, 0), {S1, [S1 | L]} end,
                           {0, [0]}, lists:seq(-1100, 1100)),
    T = list_to_tuple(lists:reverse(Pre)),
    length([A || A <- Arr1, element(A + D + 1102, T) =:= element(A - D + 1101, T)]).