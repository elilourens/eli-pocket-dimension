# Attaching a lead uses it up. Put the key back unless the player still holds one (creative mode).
execute if items entity @s weapon.* *[minecraft:custom_data~{pocket_key:true}] run return 0
execute unless items entity @s weapon.mainhand * run return run loot replace entity @s weapon.mainhand loot pocket:key
execute unless items entity @s weapon.offhand * run return run loot replace entity @s weapon.offhand loot pocket:key
loot give @s loot pocket:key
