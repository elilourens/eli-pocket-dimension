scoreboard objectives add pocket.dmg minecraft.custom:minecraft.damage_taken
scoreboard objectives add pocket.hurt dummy
scoreboard objectives add pocket.cd dummy
scoreboard objectives add pocket.held dummy
scoreboard objectives add pocket.slot dummy
scoreboard objectives add pocket.wait dummy
scoreboard objectives add pocket.hp dummy
scoreboard objectives add pocket.max dummy
scoreboard objectives add pocket.tmp dummy
scoreboard objectives add pocket.deaths deathCount
scoreboard objectives add pocket.fxm dummy
scoreboard objectives add pocket.fx dummy
scoreboard objectives add pocket.left minecraft.custom:minecraft.leave_game
execute unless score #next pocket.slot matches 0.. run scoreboard players set #next pocket.slot 0
scoreboard players set #0 pocket.tmp 0
scoreboard players set #2 pocket.tmp 2
scoreboard players set #16 pocket.tmp 16
scoreboard players set #20 pocket.tmp 20
scoreboard players set #32 pocket.tmp 32
scoreboard players set #254 pocket.tmp 254
kill @e[type=minecraft:item_display,tag=pocket.fxkey]
