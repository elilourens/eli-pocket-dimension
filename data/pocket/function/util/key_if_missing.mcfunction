# Never hand out a second key (e.g. with keepInventory on)
execute if items entity @s container.* *[minecraft:custom_data~{pocket_key:true}] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{pocket_key:true}] run return 0
execute if items entity @s player.cursor *[minecraft:custom_data~{pocket_key:true}] run return 0
loot give @s loot pocket:key
