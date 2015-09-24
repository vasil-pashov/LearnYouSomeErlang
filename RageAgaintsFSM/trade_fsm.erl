-module (trade_fsm).
-behaviour (gen_fsm).

%% public API
-export ([start/1, start_link/1, trade/2, accept_trade/1,
			make_offer/2, retract_offer/2, ready/1, cancel/1]).

-export ([init/1, handle_event/3, handle_sync_event/4, handle_info/3,
			terminate/3, code_change/4,
			%% custom states
			idle/2, idle/3, idle_wait/2, idle_wait/3, negotiate/2,
			negotiate/3, wait/2, ready/2, ready/3]).

-record (state, {name="",
					other,
					ownitems,
					otheritems,
					monitor,
					from}).

start(Name) ->
	gen_fsm:start(?MODULE, [Name], []).

start_link(Name) ->
	gen_fsm:start_link(?MODULE, [Name], []).

trade(OwnPid, OtherPid) ->
	gen_fsm:sync_send_event(OwnPid, {negotiate, OtherPid}, 30000).

accept_trade(OwnPid, OtherPid) ->
	gen_fsm:sync_send_event(OwnPid, accept_negotiate).

make_offer(OwnPid, Item) ->
	gen_fsm:send_event(OwnPid, {make_offer, Item}).

retract_offer(OwnPid, Item) ->
	
	gen_fsm:send_event(OwnPid, {retract_offer, Item}).
%% Mention that you're ready for a trade. When the other
%% player also declares being ready, the trade is done

ready(OwnPid) ->
	gen_fsm:sync_send_event(OwnPid, ready, infinity).

cancel(OwnPid) ->
	gen_fsm:sync_send_all_state_event(OwnPid, cancel).

ask_negotiate(OtherPid, OwnPid) ->
	gen_fsm:send_event(OtherPid, {ask_negotiate, OwnPid}).

  