-module(functions).
-compile(export_all).

first([H|_]) ->
    H.

second([_,S|_]) ->
    S.

same(X,X) ->
    true;
same(_,_) ->
    false.

valid_date({Date = {Y,M,D}, Time = {H,Min,S}}) ->
	io:format("The date tuple says it's ~p/~p/~p\n", [Y, M, D]),
	io:format("The time tuple says it's ~p/~p/~p\n", [H, Min, S]);
valid_date(D) ->
	io:format("Wrong data\n ~p", [D]).