function pocket:fx/cleanup
particle minecraft:large_smoke ~ ~1 ~ 0.3 0.5 0.3 0.02 15
particle minecraft:smoke ~ ~1 ~ 0.4 0.6 0.4 0.02 20
playsound minecraft:block.fire.extinguish player @a ~ ~ ~ 0.6 1.2
playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 0.6 1.5
