%% Brute Force
%%
%% -spec count_servers(N :: integer(), Logs :: [[integer()]], X :: integer(), Queries :: [integer()]) -> [integer()].
%% count_servers(N, Logs, X, Queries) ->
%%     [N - sets:size(sets:from_list([S || [S, T] <- Logs, T >= Q - X, T =< Q])) || Q <- Queries].

%% Better Approach
%%
%% -spec count_servers(N :: integer(), Logs :: [[integer()]], X :: integer(), Queries :: [integer()]) -> [integer()].
%% count_servers(N, Logs, X, Queries) ->
%%     T = list_to_tuple(lists:sort([{Tm, S} || [S, Tm] <- Logs])),
%%     M = tuple_size(T),
%%     [N - count(T, lower_bound(T, Q - X, 1, M + 1), M, Q, #{}) || Q <- Queries].
%%
%% lower_bound(_T, _V, Lo, Hi) when Lo >= Hi -> Lo;
%% lower_bound(T, V, Lo, Hi) ->
%%     Mid = (Lo + Hi) div 2,
%%     case element(1, element(Mid, T)) < V of
%%         true -> lower_bound(T, V, Mid + 1, Hi);
%%         false -> lower_bound(T, V, Lo, Mid)
%%     end.
%%
%% count(_T, J, M, _Q, Seen) when J > M -> map_size(Seen);
%% count(T, J, M, Q, Seen) ->
%%     case element(J, T) of
%%         {Tm, S} when Tm =< Q -> count(T, J + 1, M, Q, Seen#{S => true});
%%         _ -> map_size(Seen)
%%     end.

-spec count_servers(N :: integer(), Logs :: [[integer()]], X :: integer(), Queries :: [integer()]) -> [integer()].
count_servers(N, Logs, X, Queries) ->
    Sorted = lists:sort([(T bsl 17) bor S || [S, T] <- Logs]),
    Qs = lists:sort(keys(Queries, 0, [])),
    K = length(Queries),
    Cnt = atomics:new(N, []),
    Ans = atomics:new(K, []),
    go(Qs, Sorted, Sorted, 0, N, X, Cnt, Ans),
    [atomics:get(Ans, I) || I <- lists:seq(1, K)].

keys([], _I, Acc) -> Acc;
keys([Q | Qs], I, Acc) -> keys(Qs, I + 1, [(Q bsl 17) bor I | Acc]).

go([], _Ahead, _Behind, _D, _N, _X, _Cnt, _Ans) -> ok;
go([K | Ks], Ahead, Behind, D, N, X, Cnt, Ans) ->
    Q = K bsr 17,
    {Ahead1, D1} = add(Ahead, Q, Cnt, D),
    {Behind1, D2} = remove(Behind, Q - X, Cnt, D1),
    atomics:put(Ans, (K band 131071) + 1, N - D2),
    go(Ks, Ahead1, Behind1, D2, N, X, Cnt, Ans).

add([K | Rest], Q, Cnt, D) when K bsr 17 =< Q ->
    case atomics:add_get(Cnt, K band 131071, 1) of
        1 -> add(Rest, Q, Cnt, D + 1);
        _ -> add(Rest, Q, Cnt, D)
    end;
add(L, _Q, _Cnt, D) -> {L, D}.

remove([K | Rest], Lo, Cnt, D) when K bsr 17 < Lo ->
    case atomics:sub_get(Cnt, K band 131071, 1) of
        0 -> remove(Rest, Lo, Cnt, D - 1);
        _ -> remove(Rest, Lo, Cnt, D)
    end;
remove(L, _Lo, _Cnt, D) -> {L, D}.