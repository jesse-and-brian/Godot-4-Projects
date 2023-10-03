extends Area2D

@onready var speed = 2 # bullet speed multiplier
@onready var target = get_node("../Crosshair").global_position # store location of Crosshair node at creation of bullet instance
@onready var playerLocation = get_node("../Player").global_position
@onready var playerVel = get_node("../Player").velocity

#@onready var playerLocation = get_node("../Player").global_position


func _ready():
	pass
	#print(target) # print location of Crosshair node at creation of bullet instance

func _physics_process(delta):
	#global_position += target * speed * delta
	
	print(target - playerLocation)
	position += ((target - playerLocation) * speed  * delta)

	
	scale += Vector2(-.1,-.1) * 8 * delta # Make bullets get smaller as they travel
	
	if global_position.y == target.y:
		queue_free()
	if scale.x <= 0:
		queue_free()
	#print(global_position)
		
	await get_tree().create_timer(3).timeout
	queue_free()
	
#func _process(delta):
#	pass
