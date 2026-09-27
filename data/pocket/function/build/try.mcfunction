# Load the pocket chunk plus its 8 neighbours so the barrier ring can be placed
$execute in pocket:pocket run forceload add $(oxm) -16 $(oxp) 31
$execute in pocket:pocket unless loaded $(oxm) 0 -16 run return 0
$execute in pocket:pocket unless loaded $(oxp) 0 -16 run return 0
$execute in pocket:pocket unless loaded $(oxm) 0 31 run return 0
$execute in pocket:pocket unless loaded $(oxp) 0 31 run return 0
$execute in pocket:pocket positioned $(ox) 0 0 run function pocket:build/island
$data modify storage pocket:data p$(id).in set value {dim:"pocket:pocket",x:$(cx),y:101,z:8,yaw:0.0f,pitch:0.0f}
$data modify storage pocket:data p$(id).built set value 1b
$execute in pocket:pocket run forceload remove $(oxm) -16 $(oxp) 31
$execute in pocket:pocket run forceload add $(ox) 0
