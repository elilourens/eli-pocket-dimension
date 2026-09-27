# As the mob, positioned at the player
scoreboard players add #count pocket.tmp 1
data remove entity @s leash
execute if entity @s[type=#pocket:not_a_mob] run return run title @a[tag=pocket.me,limit=1] actionbar {"text":"Only mobs can go in your pocket.","color":"red"}
execute if dimension pocket:pocket run return run title @a[tag=pocket.me,limit=1] actionbar {"text":"That mob is already in your pocket.","color":"gray"}
function pocket:capture/send with storage pocket:tmp args
