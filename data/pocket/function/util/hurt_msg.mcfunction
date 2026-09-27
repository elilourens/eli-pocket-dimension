scoreboard players operation @s pocket.tmp = @s pocket.hurt
scoreboard players add @s pocket.tmp 19
scoreboard players operation @s pocket.tmp /= #20 pocket.tmp
title @s actionbar [{"text":"You were hurt recently. Wait ","color":"red"},{"score":{"name":"@s","objective":"pocket.tmp"},"color":"gold"},{"text":"s","color":"red"}]
