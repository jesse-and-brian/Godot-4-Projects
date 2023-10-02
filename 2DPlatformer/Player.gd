extends CharacterBody2D

var moveSpeed : float = 100
var jumpForce : float = 200
var gravity : float = 500
var score : int = 0

@onready var scoreText : Label = get_node("CanvasLayer/scoreText")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= moveSpeed
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += moveSpeed
		
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jumpForce
	move_and_slide()
	
	if global_position.y > 150:
		game_over()
	
func game_over ():
	get_tree().reload_current_scene()
	
func add_score (amount):
	score += amount
	scoreText.text = str("Score: ", score)
