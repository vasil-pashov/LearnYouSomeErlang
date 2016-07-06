-module(ppool_super_sup).
-behaviour(supervisor).

-export([start_link/0, stop/0, start_pool/3, stop_pool/1]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ppool}, ?MODULE, []).

stop() ->
    case whereis(ppool) of
        Pid when is_pid(Pid) ->
            exit(Pid, kill);
        _ -> ok
    end.

init([]) ->
    {ok,{{one_for_one, 6, 3600}, []}}.

start_pool(Name, Limit, MFA) ->
    io:format("Here~n"),
    ChildSpec = {Name,
                 {ppool_sup, start_link, [Name, Limit, MFA]},
                 permanent, 10500, supervisor, [ppool_sup]},
    supervisor:start_child(ppool, ChildSpec).

stop_pool(Name) ->
    supervisor:terminate_child(ppool, Name),
    supervisor:delete_child(ppool, Name).


