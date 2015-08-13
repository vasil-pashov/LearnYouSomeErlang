-module(dolphins).
-compile(export_all).

dolphin1() ->
    receive
        do_a_flip ->
            io:format("Nope\n");
        fish ->
            io:format("Thanks\n");
        _ ->
            io:format("Catch all\n")
    end.

dolphin2() ->
    receive
        {From, do_a_flip} ->
            From ! "Nope";
        {From, fish} ->
            From ! "Thanks";
        {From, _} ->
            From ! "Catch all"
    end.


dolphin3() ->
    receive
        {From, do_a_flip} ->
            From ! "Nope",
            dolphin3();
        {From, fish} ->
            From ! "Thanks",
            dolphin3();
        {From, _} ->
            From ! "Catch all",
            dolphin3()
    end.
