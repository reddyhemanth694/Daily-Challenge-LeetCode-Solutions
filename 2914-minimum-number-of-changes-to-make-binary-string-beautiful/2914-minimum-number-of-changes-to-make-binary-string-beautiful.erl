%% Brute Force
%%
%% -spec min_changes(S :: unicode:unicode_binary()) -> integer().
%% min_changes(S) -> solve(binary_to_list(S)).
%%
%% solve([]) -> 0;
%% solve(L) ->
%%     lists:min([begin
%%                    {Block, Rest} = lists:split(Len, L),
%%                    Ones = length([C || C <- Block, C =:= $1]),
%%                    min(Ones, Len - Ones) + solve(Rest)
%%                end || Len <- lists:seq(2, length(L), 2)]).

%% Better Approach
%%
%% -spec min_changes(S :: unicode:unicode_binary()) -> integer().
%% min_changes(S) ->
%%     N = byte_size(S),
%%     Dp = lists:foldl(fun(I, Dp0) -> extend(S, I, I, N, 0, maps:get(I, Dp0), Dp0) end,
%%                      #{0 => 0}, lists:seq(0, N - 2, 2)),
%%     maps:get(N, Dp).
%%
%% extend(_S, _I, J, N, _Ones, _Base, Dp) when J >= N -> Dp;
%% extend(S, I, J, N, Ones0, Base, Dp) ->
%%     Ones = Ones0 + binary:at(S, J) - $0,
%%     Len = J - I + 1,
%%     Dp1 = case Len rem 2 of
%%               0 ->
%%                   Cost = Base + min(Ones, Len - Ones),
%%                   maps:update_with(J + 1, fun(V) -> min(V, Cost) end, Cost, Dp);
%%               1 -> Dp
%%           end,
%%     extend(S, I, J + 1, N, Ones, Base, Dp1).

-spec min_changes(S :: unicode:unicode_binary()) -> integer().
min_changes(S) -> count(S, 0).

count(<<A, B, Rest/binary>>, Acc) when A =:= B -> count(Rest, Acc);
count(<<_, _, Rest/binary>>, Acc) -> count(Rest, Acc + 1);
count(<<>>, Acc) -> Acc.