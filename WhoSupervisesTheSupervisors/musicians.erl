-module(musicians).
-behaviour(gen_server).

-include("musicians_state.hrl").


-export([start_link/2, stop/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).

start_link(Role, Skill) ->
    gen_server:start_link({local, Role}, ?MODULE, [Role, Skill], []).

stop(Role) ->
    gen_server:call(Role, stop).

init([Role, Skill]) ->
    process_flag(trap_exit, true),
    Name = pick_name(),
    random:seed(erlang:now()),
    io:format("Musician ~s joined the band as ~s~n", [Name, Role]),
    State=#state{role=Role, skill=Skill, name=Name},
    TimeToPlay = random:uniform(3000),
    {ok, State, TimeToPlay}.

handle_call(stop, _From, S) ->
    {stop, normal, ok, S};
handle_call(_Message, _From, S) ->
    {noreply, S, ?DELAY}.

handle_cast(_Message, S) ->
    {noreply, S, ?DELAY}.

handle_info(timeout, S = #state{name=N, skill=good}) ->
    io:format("~s produced a sound~n", [N]),
    {noreply, S, ?DELAY};
handle_info(timeout, S = #state{name=N, skill=bad}) ->
    case random:uniform(5) of
        2 ->
            io:format("~s produced a false note~n", [N]),
            {stop, bad_note, S};
        _ ->
            io:format("~s produced a sound~n", [N]),
            {noreply, S, ?DELAY}
    end;
handle_info(_Message, S) ->
    {noreply, S, ?DELAY}.
            
            
terminate(normal, State) ->
    io:format("~s left the room (~s)~n", [State#state.name, State#state.role]);
terminate(bad_note, State) ->
    io:format("~s sucks, get out, bad playing ~s~n", [State#state.name, State#state.role]);
terminate(shutdown, State) ->
    io:format("fired ~s~n", [State#state.name]);
terminate(_Reason, State) ->
    io:format("~s kicked ot ~s~n", [State#state.name, State#state.role]).

code_change(_,State,_) ->
    {ok, State}.

pick_name() ->
    FirstNames = [<<"Freddie">>, <<"Klaus">>, <<"Jimi">>, <<"Richie">>,
                 <<"John">>, <<"James">>, <<"Billy">>],
    LastNames = [<<"Mercury">>, <<"Meine">>, <<"Hendrix">>, <<"Sambora">>,
                 <<"Bohnam">>, <<"Kottak">>, <<"Sheehan">>],
    F = lists:nth(random:uniform(7), FirstNames),
    L = lists:nth(random:uniform(7), LastNames),
    <<F/binary, <<" ">>/binary, L/binary>>.
