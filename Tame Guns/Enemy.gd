extends Area2D

@export var moveSpeed : float = 30
@export var moveDir : Vector2

var startPos : Vector2
var targetPos : Vector2

var boom = preload ("res://explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	startPos = global_position
	targetPos = startPos + moveDir


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = global_position.move_toward(targetPos, moveSpeed * delta)
	
	if global_position == targetPos:
		if global_position == startPos:
			targetPos = startPos + moveDir
		else:
			targetPos = startPos


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.game_over()

func _on_area_entered(area):
	if area.is_in_group("playerBullet"):
		var b = boom.instantiate() # Creates an instance of an explosion at the enemy
		owner.add_child(b)
		b.play("Boom")
		b.position = position
		queue_free()
		
		

