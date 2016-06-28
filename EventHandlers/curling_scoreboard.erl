-module(curling_scoreboard).
-behavior(gen_event).

-include("curling.hrl").

-export([init/1, handle_event/2, handle_call/2, handle_info/2,
         code_change/3, terminate/2]).

init([]) -> {ok, #curling_state{}}.

handle_event({set_teams, TeamA, TeamB}, State) ->
    NewState = curling_scoreboard_hw:set_teams(State, TeamA, TeamB),
    {ok, NewState};
handle_event({add_points, Team, Points}, State) ->
    case curling_scoreboard_hw:add_point(State, Team, Points) of
        {ok, NewState} -> {ok, NewState};
        {err, _} -> {ok, State}
    end;
handle_event(next_round, State) ->
    curling_scoreboard_hw:next_round(),
    {ok, State};
handle_event(_, State) ->
   io:format("Here"),
   {ok, State}.

handle_call(_, State) -> {ok, State}.

handle_info(_, State) -> {ok, State}.

code_change(_Old, State, _Extra) -> {ok, State}.

terminate(_Reason, _State) ->
    io:format("~p", [_State]),
    ok.
