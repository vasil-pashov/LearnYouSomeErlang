-module(records).
-compile(export_all).
-record(robot, {name,
                type=industrial,
                hobbies,
                details=[]}).
-record(user, {ida, name, group, age}).

first_robot() ->
    #robot{name="Optimus Prime",
          type=autobot,
          details=["Truck"]}.

car_factory(CorpName) ->
    #robot{name=CorpName, hobbies="cars"}.

admin_pannel(#user{name=Name, group=admin}) ->
    Name ++ " is allowed!";
admin_pannel(#user{name=Name}) ->
    Name ++ " is not allowed!".

adult_section(U = #user{}) when U#user.age >= 18 ->
    allowed;
adult_section(_) ->
    forbidden.

repairman(Rob) ->
    Details = Rob#robot.details,
    NewRob = Rob#robot{details=["Rpaired" | Details]},
    NewRob.
