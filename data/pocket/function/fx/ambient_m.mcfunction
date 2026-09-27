# Shimmering veil on the four invisible walls, around the player's height
$execute positioned $(ox) ~ 8 run particle minecraft:dust_color_transition{from_color:[0.55,0.35,1.0],to_color:[0.35,0.85,1.0],scale:0.7} ~ ~1 ~ 0 2.5 4 0 2
$execute positioned $(oxe) ~ 8 run particle minecraft:dust_color_transition{from_color:[0.55,0.35,1.0],to_color:[0.35,0.85,1.0],scale:0.7} ~ ~1 ~ 0 2.5 4 0 2
$execute positioned $(cx) ~ 0 run particle minecraft:dust_color_transition{from_color:[0.55,0.35,1.0],to_color:[0.35,0.85,1.0],scale:0.7} ~ ~1 ~ 4 2.5 0 0 2
$execute positioned $(cx) ~ 16 run particle minecraft:dust_color_transition{from_color:[0.55,0.35,1.0],to_color:[0.35,0.85,1.0],scale:0.7} ~ ~1 ~ 4 2.5 0 0 2
# Glowing motes drifting in the void outside the walls
$execute positioned $(owo) ~ 8 run particle minecraft:end_rod ~ ~ ~ 2 5 8 0.004 1
$execute positioned $(oeo) ~ 8 run particle minecraft:end_rod ~ ~ ~ 2 5 8 0.004 1
$execute positioned $(cx) ~ -6 run particle minecraft:end_rod ~ ~ ~ 8 5 2 0.004 1
$execute positioned $(cx) ~ 22 run particle minecraft:end_rod ~ ~ ~ 8 5 2 0.004 1
# Portal mist rising out of the void beneath the island
$execute positioned $(cx) 84 8 run particle minecraft:reverse_portal ~ ~ ~ 5 4 5 0.01 3
