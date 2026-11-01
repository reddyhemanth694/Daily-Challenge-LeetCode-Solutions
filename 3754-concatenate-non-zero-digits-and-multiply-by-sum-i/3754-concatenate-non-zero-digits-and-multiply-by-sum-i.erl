%% Brute Force
%%
%% -spec sum_and_multiply(N :: integer()) -> integer().
%% sum_and_multiply(N) ->
%%     case [C || C <- integer_to_list(N), C =/= $0] of
%%         [] -> 0;
%%         T -> list_to_integer(T) * lists:sum([C - $0 || C <- T])
%%     end.

%% Better Approach
%%
%% -spec sum_and_multiply(N :: integer()) -> integer().
%% sum_and_multiply(N) ->
%%     {X, Sum} = lists:foldl(fun(0, Acc) -> Acc;
%%                               (D, {X0, S0}) -> {X0 * 10 + D, S0 + D}
%%                            end, {0, 0}, digits(N, [])),
%%     X * Sum.
%%
%% digits(0, Acc) -> Acc;
%% digits(N, Acc) -> digits(N div 10, [N rem 10 | Acc]).

-spec sum_and_multiply(N :: integer()) -> integer().
sum_and_multiply(N) ->
    walk(N, 0, 0, 1).

walk(0, X, Sum, _P) -> X * Sum;
walk(N, X, Sum, P) ->
    case N rem 10 of
        0 -> walk(N div 10, X, Sum, P);
        D -> walk(N div 10, X + D * P, Sum + D, P * 10)
    end.