# "Full health" means the heart bar looks full. The bar rounds up, so 19.4/20 shows as
# 10 full hearts; demanding exactly 20.0 would reject players who look full.
execute store result score @s pocket.hp run data get entity @s Health 1000
execute store result score @s pocket.max run attribute @s minecraft:max_health get 1000
scoreboard players add @s pocket.hp 1000
execute if score @s pocket.hp <= @s pocket.max run return run title @s actionbar {"text":"You need full health to open your pocket.","color":"red"}
execute if score @s pocket.hurt matches 1.. run return run function pocket:util/hurt_msg
# Start the one second charge-up. fx/launch_in does the actual trip.
scoreboard players set @s pocket.fxm 1
scoreboard players set @s pocket.fx 0
