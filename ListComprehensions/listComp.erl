-module(listComp).

-export([multList/2,
        getEven/1,
        restourantMenu/2,
        sumLists/2,
        weather/1]).

multList(Mult, List) ->
    [Mult * El || El <- List].

getEven(List) ->
    [El || El <- List, El rem 2 =:= 0].

restourantMenu({Min, Max}, Products) ->
    [{Product, Price*1.07} || {Product, Price} <- Products, Price >= Min andalso Price =< Max].

sumLists(List1, List2) ->
    [L1 + L2 || L1 <- List1, L2 <- List2].

weather(List) ->
    [City || {City, fog} <- List].
