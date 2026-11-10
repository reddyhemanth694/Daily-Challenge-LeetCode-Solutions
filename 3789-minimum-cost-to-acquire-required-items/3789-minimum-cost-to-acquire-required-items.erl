%% Brute Force
%%
%% -spec minimum_cost(Cost1 :: integer(), Cost2 :: integer(), CostBoth :: integer(), Need1 :: integer(), Need2 :: integer()) -> integer().
%% minimum_cost(Cost1, Cost2, CostBoth, Need1, Need2) ->
%%     lists:min([K * CostBoth + max(0, Need1 - K) * Cost1 + max(0, Need2 - K) * Cost2 || K <- lists:seq(0, max(Need1, Need2))]).

%% Better Approach
%%
%% -spec minimum_cost(Cost1 :: integer(), Cost2 :: integer(), CostBoth :: integer(), Need1 :: integer(), Need2 :: integer()) -> integer().
%% minimum_cost(Cost1, Cost2, CostBoth, Need1, Need2) ->
%%     Total = fun(K) -> K * CostBoth + max(0, Need1 - K) * Cost1 + max(0, Need2 - K) * Cost2 end,
%%     search(Total, 0, max(Need1, Need2)).
%%
%% search(Total, Lo, Hi) when Lo >= Hi -> Total(Lo);
%% search(Total, Lo, Hi) ->
%%     Mid = (Lo + Hi) div 2,
%%     case Total(Mid) =< Total(Mid + 1) of
%%         true -> search(Total, Lo, Mid);
%%         false -> search(Total, Mid + 1, Hi)
%%     end.

-spec minimum_cost(Cost1 :: integer(), Cost2 :: integer(), CostBoth :: integer(), Need1 :: integer(), Need2 :: integer()) -> integer().
minimum_cost(Cost1, Cost2, CostBoth, Need1, Need2) ->
    Both = min(Need1, Need2),
    Both * min(CostBoth, Cost1 + Cost2) + (Need1 - Both) * min(Cost1, CostBoth) + (Need2 - Both) * min(Cost2, CostBoth).