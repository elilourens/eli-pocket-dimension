# Invisible barrier ring around the 16x16 chunk, plus a barrier ceiling so nobody climbs over.
# This caps building at one chunk without a visible world border.
fill ~-1 0 -1 ~16 254 -1 minecraft:barrier
fill ~-1 0 16 ~16 254 16 minecraft:barrier
fill ~-1 0 0 ~-1 254 15 minecraft:barrier
fill ~16 0 0 ~16 254 15 minecraft:barrier
fill ~-1 255 -1 ~16 255 16 minecraft:barrier
# The 8x8 starting island in the middle of the chunk
fill ~4 100 4 ~11 100 11 minecraft:grass_block
fill ~4 97 4 ~11 99 11 minecraft:dirt
fill ~5 95 5 ~10 96 10 minecraft:stone
fill ~6 93 6 ~9 94 9 minecraft:stone
fill ~7 92 7 ~8 92 8 minecraft:stone
