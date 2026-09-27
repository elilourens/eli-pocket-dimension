# Player logged back in: make sure no half-finished effect (like the blur) is stuck on them
scoreboard players set @s pocket.left 0
tag @s remove pocket.entering
function pocket:fx/cleanup
