scoreboard players set @s pocket.fxm 0
scoreboard players set @s pocket.fx 0
posteffect remove @s minecraft:blur
stopsound @s * minecraft:block.portal.trigger
scoreboard players operation #s pocket.tmp = @s pocket.slot
execute as @e[type=minecraft:item_display,tag=pocket.fxkey] if score @s pocket.slot = #s pocket.tmp run kill @s
