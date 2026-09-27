# Retried every tick until the pocket chunk is loaded (and built, the first time)
scoreboard players add @s pocket.wait 1
execute if score @s pocket.wait matches 200.. run return run function pocket:util/enter_timeout
function pocket:util/args
function pocket:try_enter_m with storage pocket:tmp args
