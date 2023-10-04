extends Area2D

@onready var speed = 2 # bullet speed multiplier
@onready var target = get_node("../Crosshair").global_position 		# Location of Crosshair on bullet creation
@onready var playerLocation = get_node("../Player").global_position # Location of player on bullet creation
@onready var cameraPosition = get_node("../").cameraPosition        # Camera's target position, in global coordinates on bullet creation

func _ready():
	pass
	#print(target) # print location of Crosshair node at creation of bullet instance

func _physics_process(delta):
	
	position += (target - playerLocation) * speed  * delta
	
#	if cameraPosition != get_node("../").cameraPosition:
#		position += lerp(target,)
	
	#position = position.lerp(get_node("../Crosshair").global_position, .1)
	#position = position.lerp(target,.1)
#	var characterTravel = get_node("../Player").get_position_delta()
#	print("char travel=", characterTravel)

	#print("target-PL:",target - playerLocation)

	#if get_node("../Player").isMoving == true || get_node("../Player").isJumping == true:
		
#		print("isMoving=",get_node("../Player").isMoving)
#		print("isJumping=",get_node("../Player").isJumping)
#		target = target.move_toward(playerLocation,1) // keeping to show thought process
#		position += ((target - playerLocation) * speed  * delta) // keeping to show thought process
#		var playerLocationMT = position.move_toward(playerLocation,1) // keeping to show thought process
#		var targetLocationMT = target.move_toward(position,1) // keeping to show thought process
#		position = position.move_toward(target - playerLocation,2)
		#position = position.move_toward(target,7)
#		position += ((targetLocationMT - playerLocationMT) * speed  * delta)
		
#		print("playerLocationMT:", playerLocationMT)
		
#	if get_node("../Player").isMoving == false:
#		position += ((target - playerLocation) * speed  * delta)
#		position = position.lerp(target,.1)
#		#position += ((target - playerLocation) * speed  * delta)


	
	scale += Vector2(-.1,-.1) * 10 * delta # Make bullets get smaller as they travel
	
	if global_position.y == target.y:
		queue_free()
	if scale.x <= 0:
		queue_free()
	#print(global_position)
		
	await get_tree().create_timer(3).timeout
	queue_free()
	
#func _process(delta):
#	pass
