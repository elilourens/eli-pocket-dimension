$execute unless data storage pocket:data p$(id).built run return run title @a[tag=pocket.me,limit=1] actionbar {"text":"Open your pocket once before sending mobs in.","color":"red"}
data modify entity @s PersistenceRequired set value 1b
execute at @s run function pocket:fx/mob_leave
$function pocket:util/tp_pocket with storage pocket:data p$(id).in
execute at @s run function pocket:fx/mob_arrive
title @a[tag=pocket.me,limit=1] actionbar {"text":"Sent to your pocket.","color":"light_purple"}
