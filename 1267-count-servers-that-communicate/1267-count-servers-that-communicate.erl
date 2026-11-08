%% Brute Force
%% -spec count_servers(Grid :: [[integer()]]) -> integer().
%% count_servers(Grid) ->
%%     M = length(Grid),
%%     N = length(hd(Grid)),
%%     length([1 || I <- lists:seq(1, M), J <- lists:seq(1, N),
%%                  at(Grid, I, J) =:= 1,
%%                  (lists:any(fun(K) -> K =/= J andalso at(Grid, I, K) =:= 1 end, lists:seq(1, N))
%%                   orelse lists:any(fun(K) -> K =/= I andalso at(Grid, K, J) =:= 1 end, lists:seq(1, M)))]).
%%
%% at(G, I, J) -> lists:nth(J, lists:nth(I, G)).

%% Better Approach
%% -spec count_servers(Grid :: [[integer()]]) -> integer().
%% count_servers(Grid) ->
%%     Rows = [lists:sum(R) || R <- Grid],
%%     Cols = [lists:sum(C) || C <- transpose(Grid)],
%%     lists:sum([length([1 || {V, CS} <- lists:zip(Row, Cols),
%%                             V =:= 1, ((RS > 1) orelse (CS > 1))])
%%                || {Row, RS} <- lists:zip(Grid, Rows)]).
%%
%% transpose([[] | _]) -> [];
%% transpose(M) ->
%%     [[H || [H | _] <- M] | transpose([T || [_ | T] <- M])].

%% Optimized Approach: answer = total - isolated (isolated = alone in row and column)
-spec count_servers(Grid :: [[integer()]]) -> integer().
count_servers(Grid) ->
    Rows = [lists:sum(R) || R <- Grid],
    Cols = [lists:sum(C) || C <- transpose(Grid)],
    Isolated = lists:sum([length([1 || {V, CS} <- lists:zip(Row, Cols),
                                       V =:= 1, CS =:= 1])
                          || {Row, RS} <- lists:zip(Grid, Rows), RS =:= 1]),
    lists:sum(Rows) - Isolated.

transpose([[] | _]) -> [];
transpose(M) ->
    [[H || [H | _] <- M] | transpose([T || [_ | T] <- M])].