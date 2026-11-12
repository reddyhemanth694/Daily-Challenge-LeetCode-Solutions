%% Brute Force
%%
%% -spec count_non_decreasing_subarrays(Nums :: [integer()], K :: integer()) -> integer().
%% count_non_decreasing_subarrays(Nums, K) -> brute(Nums, K, 0).
%%
%% brute([], _K, Ans) -> Ans;
%% brute([_ | Rest] = L, K, Ans) -> brute(Rest, K, Ans + extend(L, 0, 0, K)).
%%
%% extend([], _Mx, _Cost, _K) -> 0;
%% extend([X | Rest], Mx0, Cost0, K) ->
%%     Mx = max(Mx0, X),
%%     Cost = Cost0 + Mx - X,
%%     case Cost > K of
%%         true -> 0;
%%         false -> 1 + extend(Rest, Mx, Cost, K)
%%     end.

%% Better Approach
%%
%% -spec count_non_decreasing_subarrays(Nums :: [integer()], K :: integer()) -> integer().
%% count_non_decreasing_subarrays(Nums, K) ->
%%     T = list_to_tuple(Nums),
%%     N = tuple_size(T),
%%     Pre = list_to_tuple(lists:reverse(lists:foldl(fun(V, [S | _] = Acc) -> [S + V | Acc] end, [0], Nums))),
%%     Nxt = list_to_tuple(next_greater(N - 1, T, N, [], []) ++ [N]),
%%     S0 = [element(I + 1, T) * (element(I + 1, Nxt) - I) - (element(element(I + 1, Nxt) + 1, Pre) - element(I + 1, Pre))
%%           || I <- lists:seq(0, N - 1)] ++ [0],
%%     Levels = build(1, bits(N, 0), [{Nxt, list_to_tuple(S0)}], N),
%%     lists:sum([count(L, Levels, K, T, Pre, Nxt, N) || L <- lists:seq(0, N - 1)]).
%%
%% bits(0, B) -> B;
%% bits(N, B) -> bits(N bsr 1, B + 1).
%%
%% next_greater(I, _T, _N, _St, Acc) when I < 0 -> Acc;
%% next_greater(I, T, N, St0, Acc) ->
%%     V = element(I + 1, T),
%%     St = lists:dropwhile(fun(J) -> element(J + 1, T) =< V end, St0),
%%     Nx = case St of
%%              [J | _] -> J;
%%              [] -> N
%%          end,
%%     next_greater(I - 1, T, N, [I | St], [Nx | Acc]).
%%
%% build(J, Lg, Acc, _N) when J >= Lg -> Acc;
%% build(J, Lg, [{U, S} | _] = Acc, N) ->
%%     U1 = list_to_tuple([element(element(I + 1, U) + 1, U) || I <- lists:seq(0, N)]),
%%     S1 = list_to_tuple([element(I + 1, S) + element(element(I + 1, U) + 1, S) || I <- lists:seq(0, N)]),
%%     build(J + 1, Lg, [{U1, S1} | Acc], N).
%%
%% count(L, Levels, K, T, Pre, Nxt, N) ->
%%     case jump(Levels, L, 0, K, N) of
%%         {N, _} -> N - L;
%%         {Cur, Acc} -> search(Cur, element(Cur + 1, Nxt) - 1, Cur, Acc, K, T, Pre) - L + 1
%%     end.
%%
%% jump([{U, S} | Rest], Cur, Acc, K, N) when Cur < N ->
%%     Add = element(Cur + 1, S),
%%     case Acc + Add =< K of
%%         true -> jump(Rest, element(Cur + 1, U), Acc + Add, K, N);
%%         false -> jump(Rest, Cur, Acc, K, N)
%%     end;
%% jump(_, Cur, Acc, _K, _N) -> {Cur, Acc}.
%%
%% search(Lo, Hi, _Cur, _Acc, _K, _T, _Pre) when Lo >= Hi -> Lo;
%% search(Lo, Hi, Cur, Acc, K, T, Pre) ->
%%     Mid = (Lo + Hi + 1) div 2,
%%     Cost = Acc + element(Cur + 1, T) * (Mid - Cur + 1) - (element(Mid + 2, Pre) - element(Cur + 1, Pre)),
%%     case Cost =< K of
%%         true -> search(Mid, Hi, Cur, Acc, K, T, Pre);
%%         false -> search(Lo, Mid - 1, Cur, Acc, K, T, Pre)
%%     end.

-spec count_non_decreasing_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_non_decreasing_subarrays(Nums, K) ->
    T = list_to_tuple(Nums),
    N = tuple_size(T),
    go(N - 1, N - 1, queue:new(), 0, 0, K, T).

go(L, _R, _Q, _Cost, Ans, _K, _T) when L < 0 -> Ans;
go(L, R, Q0, Cost0, Ans, K, T) ->
    {Q1, Cost1} = absorb(Q0, element(L + 1, T), R, Cost0, T),
    {R1, Q2, Cost2} = shrink(R, queue:in_r(L, Q1), Cost1, K, T),
    go(L - 1, R1, Q2, Cost2, Ans + R1 - L + 1, K, T).

absorb(Q, V, R, Cost, T) ->
    case queue:peek(Q) of
        {value, I} when element(I + 1, T) =< V ->
            Q1 = queue:drop(Q),
            Stop = case queue:peek(Q1) of
                       {value, J} -> J;
                       empty -> R + 1
                   end,
            absorb(Q1, V, R, Cost + (V - element(I + 1, T)) * (Stop - I), T);
        _ ->
            {Q, Cost}
    end.

shrink(R, Q, Cost, K, _T) when Cost =< K -> {R, Q, Cost};
shrink(R, Q, Cost, K, T) ->
    {value, B} = queue:peek_r(Q),
    Q1 = case B =:= R of
             true -> queue:drop_r(Q);
             false -> Q
         end,
    shrink(R - 1, Q1, Cost - (element(B + 1, T) - element(R + 1, T)), K, T).