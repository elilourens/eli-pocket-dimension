# Runs every tick while the key is held on right-click. Only act on a fresh press.
advancement revoke @s only pocket:use_key
execute if score @s pocket.held matches 1.. run return run scoreboard players set @s pocket.held 2
scoreboard players set @s pocket.held 2
execute if score @s pocket.cd matches 1.. run return 0
scoreboard players set @s pocket.cd 10
execute if entity @s[tag=pocket.entering] run return 0
execute if score @s pocket.fxm matches 1.. run return 0
execute unless score @s pocket.slot matches 0.. run function pocket:util/assign
function pocket:util/args
execute if dimension pocket:pocket run return run function pocket:leave
function pocket:enter
