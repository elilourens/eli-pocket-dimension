# Advances this player's effect animation by one frame.
# fxm: 1 charging to enter, 2 charging to leave, 3 arriving in pocket, 4 arriving back home
execute if score @s pocket.fxm matches 1 if score @s pocket.hurt matches 1.. run return run function pocket:fx/fizzle_hurt
scoreboard players add @s pocket.fx 1
execute if score @s pocket.fxm matches 1..2 if score @s pocket.fx matches 21.. run return run function pocket:fx/cleanup
execute if score @s pocket.fxm matches 3..4 if score @s pocket.fx matches 17.. run return run function pocket:fx/cleanup
execute store result storage pocket:tmp fx.f int 1 run scoreboard players get @s pocket.fx
scoreboard players operation #s pocket.tmp = @s pocket.slot
execute if score @s pocket.fxm matches 1..2 run function pocket:fx/key_follow
execute if score @s pocket.fxm matches 1 run return run function pocket:fx/d_charge_in with storage pocket:tmp fx
execute if score @s pocket.fxm matches 2 run return run function pocket:fx/d_charge_out with storage pocket:tmp fx
execute if score @s pocket.fxm matches 3 run return run function pocket:fx/d_arrive_in with storage pocket:tmp fx
execute if score @s pocket.fxm matches 4 run return run function pocket:fx/d_arrive_out with storage pocket:tmp fx
