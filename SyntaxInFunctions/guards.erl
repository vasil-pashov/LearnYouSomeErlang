-module (guards).
-compile(export_all).

old_enough(Years) when Years > 15, Years =< 104 ->
	true;
old_enough(_) -> false.