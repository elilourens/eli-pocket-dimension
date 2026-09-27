$execute unless data storage pocket:data p$(id).built run return run function pocket:build/try with storage pocket:tmp args
$execute in pocket:pocket unless loaded $(ox) 100 0 run return run forceload add $(ox) 0
tag @s remove pocket.entering
$function pocket:util/tp_pocket with storage pocket:data p$(id).in
scoreboard players set @s pocket.fxm 3
scoreboard players set @s pocket.fx 0
