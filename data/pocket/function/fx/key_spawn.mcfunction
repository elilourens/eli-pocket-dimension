# A glowing key that hovers over the player's head and spins faster and faster
summon minecraft:item_display ~ ~2.3 ~ {Tags:["pocket.fxkey","pocket.fxnew"],item:{id:"minecraft:ominous_trial_key",count:1,components:{"minecraft:enchantment_glint_override":true}},billboard:"fixed",teleport_duration:1,brightness:{sky:15,block:15},transformation:{left_rotation:{angle:0f,axis:[0f,1f,0f]},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0f,0f,0f]}}
scoreboard players operation @e[type=minecraft:item_display,tag=pocket.fxnew] pocket.slot = @s pocket.slot
scoreboard players set @e[type=minecraft:item_display,tag=pocket.fxnew] pocket.fx 40
tag @e[type=minecraft:item_display,tag=pocket.fxnew] remove pocket.fxnew
