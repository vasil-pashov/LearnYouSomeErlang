-module(hhfuns).
-compile(export_all).

one() -> 1.

two() -> 2.

add(X, Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1 | increment(T)].

tail_increment(List) -> lists:reverse(tail_increment(List, [])).

tail_increment([], Res) -> Res;
tail_increment([H | T], Res) ->
    tail_increment(T, [H+1 | Res]).

map(_, []) -> [];
map(F, [H|T]) ->
    [F(H) | map(F, T)].

inc(El) -> El + 1.
dec(El) -> El - 1.

even(List) -> lists:reverse(even(List, [])).

even([], Res) -> Res;
even([H|T], Res) when H rem 2 == 0 ->
    even(T, [H|Res]);
even([_|T], Res) ->
    even(T, Res).

old_man(List) -> lists:reverse(old_man(List, [])).

old_man([], Res) -> Res;
old_man([Person = {male, Age}|T], Res) when Age > 60 ->
    old_man(T, [Person|Res]);
old_man([_|T], Res) ->
    old_man(T, Res).

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
    case Pred(H) of
        true -> filter(Pred, T, [H|Acc]);
        false -> filter(Pred, T, Acc)
    end.

max([H|T]) -> max2(T, H).

max2([], Max) -> Max;
max2([H|T], Max) when H > Max -> max2(T, H);
max2([_|T], Max) -> max2(T, Max).

min([H|T]) -> min2(T, H).

min2([], Min) -> Min;
min2([H|T], Min) when H < Min -> min2(T, H);
min2([_|T], Min) -> min2(T, Min).

sum(L) -> sum(L, 0).

sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, Sum + H).

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H, Start), T).

reverse(L) -> fold(fun(X, Acc) -> [X | Acc] end, [], L).
