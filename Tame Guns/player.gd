
extends CharacterBody2D

var moveSpeed : float = 85
var jumpForce : float = 200
var gravity : float = 900

var updateCrossHairPos : Vector2
var characterVector : Vector2

var bullet = preload ("res://playerbullet.tscn") # Preload the bullet scene so it can spawn
var canFire = true
var canJump = true
var isMoving = false
var isJumping = false

@onready var state_machine = $AnimationTree["parameters/playback"]

@export var fireRate = .4
@export var jumpRate = .6

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and canFire and is_on_floor() and !isMoving:
		var b = bullet.instantiate() # This creates a copy of the scene definied in var bullet above and thus the script for the bullet
		owner.add_child(b)
		b.transform = $shotSpawn.global_transform # Force the bullet to spawn at shotSpawn marker
		canFire = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(fireRate).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canFire = true # Set fire back to true so can fire again
		
	sprite_animations() # This function handles all of the player animations

func _physics_process(delta):

	velocity.x = 0
	isMoving = false
	
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
	
	if velocity.x != 0:
		isMoving = true
	
#	if isMoving:
#		print("Moving")
#	if isJumping:
#		print("Jumping or Falling")
	
	move_and_slide() # Need this to move when two objects are colliding (The floor and player). See documentation
	
	if global_position.y > 150: # if you fall off the side of the level, it reloads the scene
		game_over()
	
func game_over(): # Just reloads the screen on death
	get_tree().reload_current_scene()
	
func sprite_animations():
	
	if !isMoving and !isJumping:
		state_machine.travel("Idle")
#
	if isMoving and isJumping:
		state_machine.travel("Jump")
#
	if !isMoving and isJumping:
		state_machine.travel("Jump_n")
#
	if isMoving and !isJumping:
		state_machine.travel("Run")
		
	if velocity.x <= 0: # This flips the sprites if moving left
		$AnimatedSprite2D.scale.x = -1
#		$Body.position.x = $Body.position.x -5
	if velocity.x > 0: # Else set it back to default (1)
		$AnimatedSprite2D.scale.x = 1
#		$Body.position.x = $Body.position.x + 5
	
