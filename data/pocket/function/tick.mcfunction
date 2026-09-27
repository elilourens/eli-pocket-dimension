# Taking damage restarts the 60 second (1200 tick) calm-down timer
scoreboard players set @a[scores={pocket.dmg=1..}] pocket.hurt 1200
scoreboard players set @a[scores={pocket.dmg=1..}] pocket.dmg 0
scoreboard players remove @a[scores={pocket.hurt=1..}] pocket.hurt 1
scoreboard players remove @a[scores={pocket.cd=1..}] pocket.cd 1
scoreboard players remove @a[scores={pocket.held=1..}] pocket.held 1
execute as @a[scores={pocket.left=1..}] run function pocket:fx/rejoin

# Everyone starts with a key, and gets a new one on respawn (the old one vanishes on death).
# @e[type=player] only matches living players, so this waits until after the respawn screen.
execute as @e[type=player,tag=!pocket.joined] run function pocket:util/starter_key
execute as @e[type=player,scores={pocket.deaths=1..}] run function pocket:util/respawn_key

# Charge-up / arrival animations, then the actual trip into the pocket
execute as @e[type=player,scores={pocket.fxm=1..}] at @s run function pocket:fx/step
execute as @a[tag=pocket.entering] run function pocket:try_enter

# Ambient pocket effects every other tick
scoreboard players add #t pocket.tmp 1
scoreboard players operation #m pocket.tmp = #t pocket.tmp
scoreboard players operation #m pocket.tmp %= #2 pocket.tmp
execute if score #m pocket.tmp matches 0 as @e[type=player] at @s if dimension pocket:pocket run function pocket:fx/ambient

# Floating keys from the charge-up clean themselves up
scoreboard players remove @e[type=minecraft:item_display,tag=pocket.fxkey] pocket.fx 1
kill @e[type=minecraft:item_display,tag=pocket.fxkey,scores={pocket.fx=..0}]
