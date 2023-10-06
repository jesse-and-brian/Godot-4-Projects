extends Area2D

@onready var speed = 5 												 # bullet speed multiplier
@onready var playerMoving = get_node("../Player").isMoving			 # Is Player moving yes/no
@onready var playerLocation = get_node("../Player").global_position  # Location of player on bullet creation
@onready var playerVelocity = get_node("../Player").velocity
@onready var target = get_node("../Crosshair").global_position 		 # Snapshot of Target's Location upon firing
@onready var cameraPosition = get_node("../").cameraPosition         # Camera's target position, in global coordinates on bullet creation


func _ready():
	pass
	#print(target) # print location of Crosshair node at creation of bullet instance
	
func _process(delta):
	pass
	#print(position.x)
	
func _physics_process(delta):
	
	var currentTargetPos = get_node("../Crosshair").global_position
	var currentPlayerPos = get_node("../Player").global_position
	
	if playerMoving == false:
		position = position.move_toward(target, speed)
		#position += (target - playerLocation) * speed * delta   # Old Version of bullet behavior
	
	if playerMoving == true:
		position = position.move_toward(target, speed)
		#position += (target - playerLocation) * speed * delta
		
#		if target != get_node("../Crosshair").global_position and position.x > 0 and position <= ( target - Vector2(3,0) ):
#			position += (get_node("../Crosshair").global_position - playerLocation) * speed * delta
#			#position = position.move_toward(get_node("../Crosshair").global_position, speed+20)
#
#		if target != get_node("../Crosshair").global_position and position.x < 0 and position >= ( target - Vector2(-3,0) ):
#			position += (get_node("../Crosshair").global_position - playerLocation) * speed * delta
#			#position = position.move_toward(get_node("../Crosshair").global_position, speed+20)
	
	#if position.distance_to(target) < 20 and 
	if position.distance_to(currentTargetPos) <= 50 and target.distance_to(currentTargetPos) <= 200 and position != target and position != currentTargetPos:
		#position = global_position.move_toward(currentTargetPos, speed+5)
		position = position.lerp(currentTargetPos, .5)
	
		
		
	
#	if (playerLocation.y - target.y) >= 50:
#		position += (target - playerLocation) * speed  * delta
#
#
#	if (playerLocation.y - target.y) < 50:
#		position += (target - playerLocation) * closeSpeed  * delta
	
	scale += Vector2(-.1,-.1) * 9 * delta # Make bullets get smaller as they travel
	
	if global_position.y == target.y:
		queue_free()
	if scale.x <= 0:
		queue_free()
	#print(global_position)
		
	await get_tree().create_timer(100).timeout # destroy bullet if a lot of time passes, just in case
	queue_free()
	

