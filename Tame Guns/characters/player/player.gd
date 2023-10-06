extends CharacterBody2D
class_name Player

var moveSpeed : float = 75
var jumpForce : float = 150
var gravity : float = 700

var updateCrossHairPos : Vector2
var characterVector : Vector2

var bullet = preload ("res://playerbullet.tscn") # Preload the bullet scene so it can spawn
var canFire = true
var isMoving = false
var isJumping = false
var currentWeapon = "pistol"
var weaponMode = "standard"

@export var fireRate = .3

func _process(_delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and canFire:
		mouse_button_pressed(currentWeapon,weaponMode)
		

#var velocity = Vector2.ZERO
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	isMoving = false
	move_check(Input)



func move_check(Input):
		
	if Input.is_key_pressed(KEY_A):
		velocity.x -= moveSpeed
		print(velocity)

	if Input.is_key_pressed(KEY_D):
		velocity.x += moveSpeed
		print(velocity)

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jumpForce
		isJumping = true

	if velocity.x == -75 or velocity.x == 75:
		isMoving = true

		
		
	move_and_slide() # Need this to move when two objects are colliding (The floor and player). See documentation
	
	if global_position.y > 150: # if you fall off the side of the level, it reloads the scene
		game_over()

func switch_weapon():
	pass
	
func mouse_button_pressed(currentWeapon,weaponMode):
	
	if (currentWeapon == "pistol" && weaponMode):
		var b = bullet.instantiate() # This creates a copy of the scene definied in var bullet above and thus the script for the bullet
		owner.add_child(b) # Make a child of root ("Owner")
		b.transform = $shotSpawn.global_transform # Force the bullet to spawn at shotSpawn marker
		canFire = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(fireRate).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canFire = true # Set fire back to true so can fire again
	
	if(currentWeapon == "Lazer" && weaponMode):
#		var z = Lazer.instantiate()
#		owner.add_child(z)
		
		pass	
	if(currentWeapon == "machineGun"):
		pass
		
	if(currentWeapon == "rocketLauncher"):
		pass	
		
	if(currentWeapon == "Lazer"):
#		var z = Lazer.instantiate()
		pass
 
func game_over (): # Just reloads the screen on death
	get_tree().reload_current_scene()
	
