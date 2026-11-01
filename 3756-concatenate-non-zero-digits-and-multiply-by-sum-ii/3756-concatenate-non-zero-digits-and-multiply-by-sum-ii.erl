%% Brute Force
%%
%% -spec sum_and_multiply(S :: unicode:unicode_binary(), Queries :: [[integer()]]) -> [integer()].
%% sum_and_multiply(S, Queries) ->
%%     [begin
%%          {X, Sum} = lists:foldl(fun($0, Acc) -> Acc;
%%                                    (C, {X0, S0}) -> {(X0 * 10 + C - $0) rem 1000000007, S0 + C - $0}
%%                                 end, {0, 0}, binary_to_list(binary:part(S, L, R - L + 1))),
%%          X * Sum rem 1000000007
%%      end || [L, R] <- Queries].

%% Better Approach
%%
%% -spec sum_and_multiply(S :: unicode:unicode_binary(), Queries :: [[integer()]]) -> [integer()].
%% sum_and_multiply(S, Queries) ->
%%     Mod = 1000000007,
%%     {Pre, Cnt, Sum} =
%%         lists:foldl(fun(C, {[P | _] = Ps, [K | _] = Ks, [T | _] = Ts}) ->
%%                             case C - $0 of
%%                                 0 -> {[P | Ps], [K | Ks], [T | Ts]};
%%                                 D -> {[(P * 10 + D) rem Mod | Ps], [K + 1 | Ks], [T + D | Ts]}
%%                             end
%%                     end, {[0], [0], [0]}, binary_to_list(S)),
%%     [PreT, CntT, SumT] = [list_to_tuple(lists:reverse(Xs)) || Xs <- [Pre, Cnt, Sum]],
%%     [begin
%%          K = element(R + 2, CntT) - element(L + 1, CntT),
%%          X = ((element(R + 2, PreT) - element(L + 1, PreT) * power(10, K, Mod)) rem Mod + Mod) rem Mod,
%%          X * (element(R + 2, SumT) - element(L + 1, SumT)) rem Mod
%%      end || [L, R] <- Queries].
%%
%% power(_B, 0, _M) -> 1;
%% power(B, E, M) when E rem 2 =:= 0 -> power(B * B rem M, E div 2, M);
%% power(B, E, M) -> B * power(B, E - 1, M) rem M.

-spec sum_and_multiply(S :: unicode:unicode_binary(), Queries :: [[integer()]]) -> [integer()].
sum_and_multiply(S, Queries) ->
    Mod = 1000000007,
    {Pre, Cnt, Sum, Pw} =
        lists:foldl(fun(C, {[P | _] = Ps, [K | _] = Ks, [T | _] = Ts, [W | _] = Ws}) ->
                            case C - $0 of
                                0 -> {[P | Ps], [K | Ks], [T | Ts], [W * 10 rem Mod | Ws]};
                                D -> {[(P * 10 + D) rem Mod | Ps], [K + 1 | Ks], [T + D | Ts], [W * 10 rem Mod | Ws]}
                            end
                    end, {[0], [0], [0], [1]}, binary_to_list(S)),
    [PreT, CntT, SumT, PwT] = [list_to_tuple(lists:reverse(Xs)) || Xs <- [Pre, Cnt, Sum, Pw]],
    [begin
         K = element(R + 2, CntT) - element(L + 1, CntT),
         X = ((element(R + 2, PreT) - element(L + 1, PreT) * element(K + 1, PwT)) rem Mod + Mod) rem Mod,
         X * (element(R + 2, SumT) - element(L + 1, SumT)) rem Mod
     end || [L, R] <- Queries].