-module(road).
-export([main/1]).

main(FileName) ->
    {ok, Bin} = file:read_file(FileName),
    Map = parse_map(Bin),
    optimal_path(Map).

parse_map(Bin) when is_binary(Bin) ->
    parse_map(binary_to_list(Bin));
parse_map(Str) when is_list(Str) ->
    Values = [list_to_integer(X) || X <- string:tokens(Str, "\t\n\r ")],
    group_vals(Values, []).

group_vals([], Acc) ->
    lists:reverse(Acc);
group_vals([A,B,X|T], Acc) ->
    group_vals(T, [{A,B,X}| Acc]).
    
optimal_path(Map) ->
    {A, B} = lists:foldl(fun optimal_step/2, {{0, []}, {0, []}}, Map),
    {_Dist,Path} = if hd(element(2,A)) =/= 0 -> A;
                      hd(element(2,B)) =/= 0 -> B
                    end,
    lists:reverse(Path).

optimal_step({A,B,X}, {{DistA,PathA}, {DistB,PathB}}) ->
    OptA1 = {DistA + A, [{a,A}|PathA]},
    OptA2 = {DistB + B + X, [{x,X}, {b,B}|PathB]},
    OptB1 = {DistB + B, [{b,B}|PathB]},
    OptB2 = {DistA + A + X, [{x,X}, {a,A}|PathA]},
    {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.
