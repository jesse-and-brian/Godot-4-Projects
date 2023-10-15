extends Area2D


func _on_area_entered(area):
	if area.is_in_group("playerBullet"):
		get_node("../Player").machineGunAmmo += 40 # Give player 40 bullets for machine gun
		get_node("../Player").hasMachineGun = true # Enable machine gun fire script in player.gd script
		get_node("../Player/Weapon_Pick_Up_Sounds/HeavyMachineGun").play() # Play the pickup sound
		queue_free()
