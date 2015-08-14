-module (linkmon).
-compile(export_all).

myproc() ->
	timer:sleep(5000),
	exit(reason).

chain(0) ->
	receive 
		_-> ok
	after 2000 ->
		exit("Chain Dies Here")
	end;
chain(N) ->
	Pid = spawn(fun() -> chain(N-1) end),
	link(Pid),
	receive
		_-> ok 
	end.

start_critic() ->
	spawn(?MODULE, critic, []).

judge(Pid, Band, Album) ->
	Pid ! {self(), {Band, Album}},
	receive 
		{Pid, Crit} -> Crit
	after 2000 ->
		timeout
	end.

critic() ->
	receive 
		{From, {"Bon Jovi", "Slippery When Wet"}} ->
			From ! {self(), "Awesome"};
		{From, {"Scorpions", "Love at First Sting"}} ->
			From ! {self(), "Amazing"};
		{From, {_, _}} ->
			From ! {self(), "Haven heard them"}
	end,
	critic().

start_critic2() ->
	spawn(?MODULE, restarter, []). 

restarter() ->
	process_flag(trap_exit, ture),
	Pid = spawn(?MODULE, critic, []),
	register(critic2, Pid), 
	receive 
		{'EXIT', Pid, normal} ->
			ok;
		{'EXIT', Pid, shutdown} ->
			ok;
		{'EXIT', Pid, _} ->
			restarter()
	end.

judge2(Band, Album) ->
	Ref = make_ref(),
	critic ! {self(), Ref {Band, Album}}, 
	receive
		{Ref, Critics} -> Critics
	after 2000 ->
		timeout 
	end.

critic2() ->
	receive 
		{From, Ref, {"Bon Jovi", "Slippery When Wet"}} ->
			From ! {Ref, "Awesome"};
		{From, Ref, {"Scorpions", "Love at First Sting"}} ->
			From ! {Ref, "Amazing"};
		{From, Ref, {_, _}} ->
			From ! {Ref, "Haven heard them"}
	end,
	critic2().