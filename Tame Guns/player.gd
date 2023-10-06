
extends CharacterBody2D

var moveSpeed : float = 75
var jumpForce : float = 150
var gravity : float = 700

var updateCrossHairPos : Vector2
var characterVector : Vector2

var bullet = preload ("res://playerbullet.tscn") # Preload the bullet scene so it can spawn
var canFire = true
var isMoving = false
var isJumping = false

@export var fireRate = .3

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and canFire: # If the Cooldown for firing is up, fire if left mouse button has been clicked
		var b = bullet.instantiate() # This creates a copy of the scene definied in var bullet above and thus the script for the bullet
		owner.add_child(b) # Make a child of root ("Owner")
		b.transform = $shotSpawn.global_transform # Force the bullet to spawn at shotSpawn marker
		canFire = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(fireRate).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canFire = true # Set fire back to true so can fire again

#var velocity = Vector2.ZERO
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	isMoving = false
	
	if Input.is_key_pressed(KEY_A):
		velocity.x -= moveSpeed
		#print(velocity)

	if Input.is_key_pressed(KEY_D):
		velocity.x += moveSpeed
		#print(velocity)

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jumpForce
		isJumping = true

	if velocity.x == -75 or velocity.x == 75:
		isMoving = true
		
		
	move_and_slide() # Need this to move when two objects are colliding (The floor and player). See documentation
	
	if global_position.y > 150: # if you fall off the side of the level, it reloads the scene
		game_over()
	
func game_over(): # Just reloads the screen on death
	get_tree().reload_current_scene()
	
