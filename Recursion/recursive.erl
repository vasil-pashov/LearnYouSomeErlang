-module (recursive).
-export ([fact/1,
			tail_fact/1,
			list_len/1,
			tail_list_len/1,
			dublicate/2,
			tail_dublicate/2,
			reverse/1,
			tail_reverse/1,
			sublist/2,
			tail_sublist/2,
			zip/2,
			tail_zip/2,
			quicksort/1]).

fact(N) when N =:= 0 -> 1;
fact(N) when N > 0 -> N * fact(N-1).

tail_fact(N) -> tail_fact(N, 1).

tail_fact(0, Result) -> Result;
tail_fact(N, CurrentRes) ->
	if N < 0 -> <<"Must be positive">>;
		N > 0 -> tail_fact(N - 1, CurrentRes * N)
	end.

list_len([]) -> 0;
list_len([_|T]) -> 1 + list_len(T).

tail_list_len(List) -> tail_list_len(List, 0).

tail_list_len([], Len) -> Len;
tail_list_len([_|T], CurrentLen) -> tail_list_len(T, CurrentLen + 1).

dublicate(0, _) -> [];
dublicate(N, Term) -> [Term | dublicate(N-1, Term)].

tail_dublicate(N, Term) -> tail_dublicate(N, Term, []).

tail_dublicate(0, _, Res) -> Res;
tail_dublicate(N, Term, CurrentRes) when N > 0 ->
	tail_dublicate(N-1, Term, [Term | CurrentRes]).

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse(List) -> tail_reverse(List, []).

tail_reverse([], Res) -> Res;
tail_reverse([H|T], CurrentRes) -> tail_reverse(T, [H | CurrentRes]).

sublist(_, 0) -> [];
sublist([], _) -> [];
sublist([H|T], N) -> [H | sublist(T, N-1)].

tail_sublist(List, N) -> tail_reverse(tail_sublist(List, N, [])).

tail_sublist([], _, Res) -> Res;
tail_sublist(_, 0, Res) -> Res;
tail_sublist([H|T], N, Res) -> tail_sublist(T, N - 1, [H | Res]).

zip([],[]) -> [];
zip([H1|T1], [H2|T2]) -> [{H1, H2} | zip(T1, T2)].

tail_zip(L1, L2) -> lists:reverse(tail_zip(L1, L2, [])).

tail_zip([],[], Res) -> Res;
tail_zip([H1|T1], [H2|T2], Res) -> tail_zip(T1, T2, [{H1, H2} | Res]).

quicksort([]) -> [];
quicksort([Pivot|Tail]) ->
	{Smaller, Larger} = partition(Tail, Pivot, [], []),
	quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition([],_, Smaller, Larger) -> {Smaller, Larger};
partition([H|T], Pivot, Smaller, Larger) ->
	if
		H =< Pivot -> partition(T, Pivot, [H | Smaller], Larger);
		H > Pivot -> partition(T, Pivot, Smaller, [H|Larger])
	end.