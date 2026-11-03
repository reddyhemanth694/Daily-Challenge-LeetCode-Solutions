%% Brute Force
%%
%% -spec min_operations(Nums :: [integer()], X :: integer(), K :: integer()) -> integer().
%% min_operations(Nums, X, K) ->
%%     Arr = list_to_tuple(Nums),
%%     dfs(Arr, tuple_size(Arr), X, 0, K).
%%
%% dfs(_Arr, _N, _X, _I, 0) -> 0;
%% dfs(_Arr, N, X, I, J) when N - I < J * X -> infinity;
%% dfs(Arr, N, X, I, J) ->
%%     min(dfs(Arr, N, X, I + 1, J), window_cost(Arr, X, I) + dfs(Arr, N, X, I + X, J - 1)).
%%
%% window_cost(Arr, X, I) ->
%%     W = lists:sort([element(T, Arr) || T <- lists:seq(I + 1, I + X)]),
%%     Med = lists:nth(X div 2 + 1, W),
%%     lists:sum([abs(V - Med) || V <- W]).

%% Better Approach
%%
%% -spec min_operations(Nums :: [integer()], X :: integer(), K :: integer()) -> integer().
%% min_operations(Nums, X, K) ->
%%     Arr = list_to_tuple(Nums),
%%     N = tuple_size(Arr),
%%     Cost = [begin
%%                 W = lists:sort([element(T, Arr) || T <- lists:seq(I + 1, I + X)]),
%%                 Med = lists:nth(X div 2 + 1, W),
%%                 lists:sum([abs(V - Med) || V <- W])
%%             end || I <- lists:seq(0, N - X)],
%%     dp(K, N, X, list_to_tuple(Cost), erlang:make_tuple(N + 1, 0)).
%%
%% dp(0, _N, _X, _Cost, Prev) -> element(tuple_size(Prev), Prev);
%% dp(J, N, X, Cost, Prev) -> dp(J - 1, N, X, Cost, list_to_tuple(row(0, N, X, Cost, Prev, 1 bsl 62, []))).
%%
%% row(I, N, _X, _Cost, _Prev, _Last, Acc) when I > N -> lists:reverse(Acc);
%% row(I, N, X, Cost, Prev, Last, Acc) when I < X -> row(I + 1, N, X, Cost, Prev, Last, [Last | Acc]);
%% row(I, N, X, Cost, Prev, Last, Acc) ->
%%     V = min(Last, element(I - X + 1, Prev) + element(I - X + 1, Cost)),
%%     row(I + 1, N, X, Cost, Prev, V, [V | Acc]).

-spec min_operations(Nums :: [integer()], X :: integer(), K :: integer()) -> integer().
min_operations(Nums, X, K) ->
    N = length(Nums),
    Keys = lists:sort(keys(Nums, 0, [])),
    RankA = atomics:new(N, []),
    ValT = list_to_tuple(ranks(Keys, 0, RankA, [])),
    Ranks = [atomics:get(RankA, I) || I <- lists:seq(1, N)],
    Lv = list_to_tuple(levels(N, [])),
    Half = (X + 1) div 2,
    {FirstR, AheadR} = lists:split(X, Ranks),
    {FirstN, AheadN} = lists:split(X, Nums),
    lists:foreach(fun(R) -> ins(R, 1, Lv) end, FirstR),
    Sorted = lists:sort(FirstR),
    SumL = lists:sum([element(R + 1, ValT) || R <- lists:sublist(Sorted, Half)]),
    ML = lists:nth(Half, Sorted),
    Total = lists:sum(FirstN),
    C0 = Total - 2 * SumL + element(ML + 1, ValT) * (2 * Half - X),
    Cost = win(AheadN, AheadR, Nums, Ranks, ML, SumL, Total, Half, X, ValT, Lv, [C0]),
    dp(K, X, Cost, lists:duplicate(N + 1, 0)).

keys([], _I, Acc) -> Acc;
keys([V | Vs], I, Acc) -> keys(Vs, I + 1, [((V + 1000000) bsl 17) + I | Acc]).

ranks([], _R, _RankA, Acc) -> lists:reverse(Acc);
ranks([Key | Ks], R, RankA, Acc) ->
    atomics:put(RankA, (Key band 131071) + 1, R),
    ranks(Ks, R + 1, RankA, [(Key bsr 17) - 1000000 | Acc]).

levels(Size, Acc) ->
    W = (Size + 31) bsr 5,
    Acc1 = [atomics:new(W, []) | Acc],
    case W of
        1 -> lists:reverse(Acc1);
        _ -> levels(W, Acc1)
    end.

ins(R, L, Lv) ->
    Bit = 1 bsl (R band 31),
    W = R bsr 5,
    case atomics:add_get(element(L, Lv), W + 1, Bit) of
        Bit when L < tuple_size(Lv) -> ins(W, L + 1, Lv);
        _ -> ok
    end.

del(R, L, Lv) ->
    W = R bsr 5,
    case atomics:sub_get(element(L, Lv), W + 1, 1 bsl (R band 31)) of
        0 when L < tuple_size(Lv) -> del(W, L + 1, Lv);
        _ -> ok
    end.

nxt(R, L, Lv) ->
    W = R bsr 5,
    case atomics:get(element(L, Lv), W + 1) bsr ((R band 31) + 1) of
        0 -> nxt(W, L + 1, Lv);
        M -> down_low(R + 1 + low(M), L, Lv)
    end.

down_low(R, 1, _Lv) -> R;
down_low(R, L, Lv) -> down_low((R bsl 5) + low(atomics:get(element(L - 1, Lv), R + 1)), L - 1, Lv).

prv(R, L, Lv) ->
    W = R bsr 5,
    case atomics:get(element(L, Lv), W + 1) band ((1 bsl (R band 31)) - 1) of
        0 -> prv(W, L + 1, Lv);
        M -> down_high((W bsl 5) + high(M), L, Lv)
    end.

down_high(R, 1, _Lv) -> R;
down_high(R, L, Lv) -> down_high((R bsl 5) + high(atomics:get(element(L - 1, Lv), R + 1)), L - 1, Lv).

low(M) -> high(M band (-M)).

high(M) -> trunc(math:log2(M)).

win([], _, _, _, _, _, _, _, _, _, _, Acc) -> lists:reverse(Acc);
win([A | As], [RA | RAs], [B | Bs], [RB | RBs], ML, SumL, Total, Half, X, ValT, Lv, Acc) ->
    ins(RA, 1, Lv),
    {ML1, S1} = case RA < ML of
                    true -> {prv(ML, 1, Lv), SumL + A - element(ML + 1, ValT)};
                    false -> {ML, SumL}
                end,
    del(RB, 1, Lv),
    {ML2, S2} = case RB =< ML1 of
                    true ->
                        Q = nxt(ML1, 1, Lv),
                        {Q, S1 - B + element(Q + 1, ValT)};
                    false -> {ML1, S1}
                end,
    T = Total + A - B,
    C = T - 2 * S2 + element(ML2 + 1, ValT) * (2 * Half - X),
    win(As, RAs, Bs, RBs, ML2, S2, T, Half, X, ValT, Lv, [C | Acc]).

dp(0, _X, _Cost, Prev) -> lists:last(Prev);
dp(J, X, Cost, Prev) -> dp(J - 1, X, Cost, lists:duplicate(X, 1 bsl 58) ++ row(Prev, Cost, 1 bsl 58, [])).

row(_, [], _Last, Acc) -> lists:reverse(Acc);
row([P | Ps], [C | Cs], Last, Acc) ->
    V = min(Last, P + C),
    row(Ps, Cs, V, [V | Acc]).