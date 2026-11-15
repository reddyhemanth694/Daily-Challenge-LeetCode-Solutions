%% Brute Force
%%
%% -spec num_of_subarrays(Arr :: [integer()]) -> integer().
%% num_of_subarrays(Arr) ->
%%     N = length(Arr),
%%     Count = length([1 || I <- lists:seq(1, N), J <- lists:seq(I, N),
%%                          lists:sum(lists:sublist(Arr, I, J - I + 1)) rem 2 =:= 1]),
%%     Count rem 1000000007.

%% Better Approach
%%
%% -spec num_of_subarrays(Arr :: [integer()]) -> integer().
%% num_of_subarrays(Arr) -> better(Arr, 0) rem 1000000007.
%%
%% better([], Acc) -> Acc;
%% better([_ | Rest] = L, Acc) -> better(Rest, Acc + odd_sums(L, 0, 0)).
%%
%% odd_sums([], _Sum, C) -> C;
%% odd_sums([X | T], Sum0, C) ->
%%     Sum = Sum0 + X,
%%     odd_sums(T, Sum, C + Sum rem 2).

-spec num_of_subarrays(Arr :: [integer()]) -> integer().
num_of_subarrays(Arr) -> count(Arr, 0, 1, 0, 0).

count([], _Odd, _Even, _Sum, Ans) -> Ans;
count([X | T], Odd, Even, Sum0, Ans) ->
    Sum = Sum0 + X,
    case Sum rem 2 of
        1 -> count(T, Odd + 1, Even, Sum, (Ans + Even) rem 1000000007);
        0 -> count(T, Odd, Even + 1, Sum, (Ans + Odd) rem 1000000007)
    end.