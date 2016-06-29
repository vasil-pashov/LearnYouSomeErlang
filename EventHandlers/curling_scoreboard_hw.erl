-module(curling_scoreboard_hw).
-export([add_points/3, next_round/1, set_teams/3, reset_board/0]).

-include("curling.hrl").

add_points(State=#curling_state{teams=Teams}, Team, Points) ->
    case maps:find(Team, Teams) of
        {ok, TeamPts} ->
            {ok, State#curling_state{teams=maps:update(Team, TeamPts+Points, Teams)}};
        error ->
            {error, no_such_team}
    end.

next_round(State=#curling_state{round=Round}) ->
    io:format("Start next round"),
    State#curling_state{round=Round + 1}.

set_teams(State=#curling_state{teams=Teams}, TeamA, TeamB) ->
    io:format("~s vs. ~s", [TeamA, TeamB]),
    State#curling_state{teams=maps:put(TeamB, 0, maps:put(TeamA, 0, Teams))}.

reset_board() -> io:format("RESET").
