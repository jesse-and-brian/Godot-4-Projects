extends Area2D

@onready var speed = 4 												 # bullet speed multiplier
@onready var playerMoving = get_node("../Player").isMoving			 # Is Player moving yes/no
@onready var playerLocation = get_node("../Player").global_position  # Location of player on bullet creation
@onready var playerVelocity = get_node("../Player").velocity
@onready var target = get_node("../Crosshair").global_position 		 # Location of Crosshair on bullet creation
@onready var cameraPosition = get_node("../").cameraPosition         # Camera's target position, in global coordinates on bullet creation


func _ready():
	pass
	#print(target) # print location of Crosshair node at creation of bullet instance
	
func _process(delta):
	print(position.x)
	
	if playerMoving == false:
		position = global_position.move_toward(target, speed)
	#position += (target - playerLocation) * speed * delta   # Old Version of bullet behavior
	
	if playerMoving == true:
		position = global_position.move_toward(target, speed)
		
#		if target != get_node("../Crosshair").global_position and position.x > 0 and position <= ( target - Vector2(3,0) ):
#			position += (get_node("../Crosshair").global_position - playerLocation) * speed * delta
#			#position = position.move_toward(get_node("../Crosshair").global_position, speed+20)
#
#		if target != get_node("../Crosshair").global_position and position.x < 0 and position >= ( target - Vector2(-3,0) ):
#			position += (get_node("../Crosshair").global_position - playerLocation) * speed * delta
#			#position = position.move_toward(get_node("../Crosshair").global_position, speed+20)
func _physics_process(delta):
	pass
	#position += (target - playerLocation) * speed * delta
	
	
		
		
	
#	if (playerLocation.y - target.y) >= 50:
#		position += (target - playerLocation) * speed  * delta
#
#
#	if (playerLocation.y - target.y) < 50:
#		position += (target - playerLocation) * closeSpeed  * delta
	
	scale += Vector2(-.1,-.1) * 15 * delta # Make bullets get smaller as they travel
	
	if global_position.y == target.y:
		queue_free()
	if scale.x <= 0:
		queue_free()
	#print(global_position)
		
	await get_tree().create_timer(10).timeout
	queue_free()
	

