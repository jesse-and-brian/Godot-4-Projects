
extends CharacterBody2D

var moveSpeed : float = 65
var jumpForce : float = 200
var gravity : float = 900

var updateCrossHairPos : Vector2
var characterVector : Vector2

var bullet = preload ("res://playerbullet.tscn") # Preload the bullet scene so it can spawn
var canFire = true
var canJump = true
var isMoving = false
var isJumping = false

@onready var _animated_sprite = $AnimatedSprite2D

@export var fireRate = .3
@export var jumpRate = .6

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and canFire and is_on_floor(): # If the Cooldown for firing is up, fire if left mouse button has been clicked
		var b = bullet.instantiate() # This creates a copy of the scene definied in var bullet above and thus the script for the bullet
		owner.add_child(b) # Make a child of root ("Owner")
		b.transform = $shotSpawn.global_transform # Force the bullet to spawn at shotSpawn marker
		canFire = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(fireRate).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canFire = true # Set fire back to true so can fire again

#var velocity = Vector2.ZERO
func _physics_process(delta):

	velocity.x = 0
	isMoving = false
	print(isJumping)
		
	if is_on_floor():
		isJumping = false
	
	if !is_on_floor():
		isJumping = true
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_key_pressed(KEY_A):
		velocity.x -= moveSpeed

	if Input.is_key_pressed(KEY_D):
		velocity.x += moveSpeed
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor() and canJump:
		velocity.y = -jumpForce
		canJump = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(jumpRate).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canJump = true # Set fire back to true so can fire again
		


	
	if velocity.x == -65 or velocity.x == 65:
		isMoving = true
	
	if velocity.x == -65:
		_animated_sprite.flip_h = true
	else:
		_animated_sprite.flip_h = false
	
	if !isMoving and !isJumping:
		_animated_sprite.play("Idle")
	
	if isMoving and isJumping:
		_animated_sprite.play("Jump")
		
	if !isMoving and isJumping:
		_animated_sprite.play("Jump-n")
	
	if isMoving and !isJumping:
		_animated_sprite.play("Run")


	
		
		
	move_and_slide() # Need this to move when two objects are colliding (The floor and player). See documentation
	
	if global_position.y > 150: # if you fall off the side of the level, it reloads the scene
		game_over()
	
func game_over(): # Just reloads the screen on death
	get_tree().reload_current_scene()
	
