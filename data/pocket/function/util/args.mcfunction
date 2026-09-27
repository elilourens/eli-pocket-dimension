# Pockets sit in a row along +x, 32 blocks apart: pocket chunk, empty chunk, next pocket chunk.
# pocket:tmp args = {id, ox: chunk origin x, oxe: east wall x, cx: centre x,
#                    oxm/oxp: neighbour chunk range, owo/oeo: just outside the west/east walls}
execute store result storage pocket:tmp args.id int 1 run scoreboard players get @s pocket.slot
scoreboard players operation #ox pocket.tmp = @s pocket.slot
scoreboard players operation #ox pocket.tmp *= #32 pocket.tmp
execute store result storage pocket:tmp args.ox int 1 run scoreboard players get #ox pocket.tmp
scoreboard players operation #v pocket.tmp = #ox pocket.tmp
execute store result storage pocket:tmp args.cx int 1 run scoreboard players add #v pocket.tmp 8
execute store result storage pocket:tmp args.oxe int 1 run scoreboard players add #v pocket.tmp 8
execute store result storage pocket:tmp args.oeo int 1 run scoreboard players add #v pocket.tmp 6
execute store result storage pocket:tmp args.oxp int 1 run scoreboard players add #v pocket.tmp 9
scoreboard players operation #v pocket.tmp = #ox pocket.tmp
execute store result storage pocket:tmp args.owo int 1 run scoreboard players remove #v pocket.tmp 6
execute store result storage pocket:tmp args.oxm int 1 run scoreboard players remove #v pocket.tmp 10
