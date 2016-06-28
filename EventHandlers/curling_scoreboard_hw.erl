-module(curling_scoreboard_hw).
-export([add_point/3, next_round/0, set_teams/3, reset_board/0]).

-include("curling.hrl").

add_point(State=#curling_state{team_a=Team, team_a_score=Score}, Team, Points) ->     
    io:format("Team ~s scores", [Team]),
    {ok, State#curling_state{team_a_score=Score+Points}};
add_point(State=#curling_state{team_b=Team, team_b_score=Score}, Team, Points) ->     
    io:format("Team ~s scores", [Team]),
    {ok, State#curling_state{team_b_score=Score+Points}};
add_point(_State, Team, _Points) ->     
    io:format("~p", [_State]),
    io:format("No such team: ~p", [Team]),
    {err, no_team}.


next_round() -> io:format("Start next round").

set_teams(State, TeamA, TeamB) ->
    io:format("~s vs. ~s", [TeamA, TeamB]),
    State#curling_state{team_a=TeamA, team_b=TeamB}.

reset_board() -> io:format("RESET").
