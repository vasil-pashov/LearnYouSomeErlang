-module (tree).	
-export ([empty/0,
			insert/3,
			lookup/2]).

empty() -> {node, nil}.

insert(Key, Val, {node, nill}) ->
	{node, {Key, Val, {node, nill}, {node, nill}}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key ->
	{node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key ->
	{node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) ->
	{node, {NewKey, NewVal, Smaller, Larger}}.

lookup(_, {node, nil}) -> undefined;
lookup(Key, {node, {Key, Val, _, _}}) -> {ok, Val};
lookup(SKey, {node, {Key, Val, Smaller, _}}) when SKey < Key ->
	lookup(SKey, Smaller);
lookup(SKey, {node, {_, _, _, Larger}}) ->
	lookup(SKey, Larger);