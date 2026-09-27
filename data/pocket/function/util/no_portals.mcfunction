# Portals don't work in the pocket: wipe any portal blocks in a band around the player's height.
# Runs every tick, so a lit portal is gone before anyone can use it.
execute store result score #py pocket.tmp run data get entity @s Pos[1]
execute if score #py pocket.tmp matches ..-1 run return 0
scoreboard players operation #lo pocket.tmp = #py pocket.tmp
scoreboard players remove #lo pocket.tmp 6
scoreboard players operation #lo pocket.tmp > #0 pocket.tmp
scoreboard players operation #hi pocket.tmp = #py pocket.tmp
scoreboard players add #hi pocket.tmp 6
scoreboard players operation #hi pocket.tmp < #254 pocket.tmp
function pocket:util/args
execute store result storage pocket:tmp args.plo int 1 run scoreboard players get #lo pocket.tmp
execute store result storage pocket:tmp args.phi int 1 run scoreboard players get #hi pocket.tmp
function pocket:util/no_portals_m with storage pocket:tmp args
