# The key is a lead underneath, so the game itself only lets it attach to leashable mobs.
# We catch that leash, cut it, and send the mob into the pocket.
advancement revoke @s only pocket:leash_key
scoreboard players set @s pocket.held 2
scoreboard players set @s pocket.cd 10
execute unless score @s pocket.slot matches 0.. run function pocket:util/assign
function pocket:util/args
tag @s add pocket.me
scoreboard players set #count pocket.tmp 0
execute as @e[type=!minecraft:player,distance=..16] if function pocket:capture/is_mine run function pocket:capture/one
tag @s remove pocket.me
execute if score #count pocket.tmp matches 1.. run function pocket:capture/refund
