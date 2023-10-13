extends Area2D

@export var moveSpeed : float = .4
@export var moveDir : Vector2

@onready var startPos = global_position
@onready var playerPos = get_node("../Player").global_position

var targetPos : Vector2
var currentPlayerPos : Vector2
var secondMovement : bool
var canFire = true
var firstBulletDelay : int = 0

var boom = preload ("res://explosion.tscn")
var enemyBullet = preload ("res://enemybullet.tscn") # Preload the bullet scene so it can spawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	currentPlayerPos = get_node("../Player").global_position
	
	firstBulletDelay += 1 # delays first shot
	
	if canFire and firstBulletDelay >= 150:
		
		var eb = enemyBullet.instantiate() # This creates a copy of the scene definied in var bullet above and thus the script for the bullet
		eb.set_owner(get_node("../EnemySpwaner"))
		add_sibling(eb)
		eb.transform = $shotSpawn.global_transform # Force the bullet to spawn at shotSpawn marker
		canFire = false # Set ability to fire to false, so can't fire
		await get_tree().create_timer(2).timeout # This waits to execute the next line. Adjust variable to be able to fire faster.
		canFire = true # Set fire back to true so can fire again
	
	
	if global_position.distance_to(playerPos) > 1 and !secondMovement:
		global_position = global_position.move_toward(playerPos, moveSpeed)
		
	if global_position.distance_to(startPos) > 100:
		secondMovement = true
	
	if secondMovement:
		#global_position = global_position.move_toward(currentPlayerPos, moveSpeed) # move to player's new location
		global_position = global_position.move_toward(startPos, moveSpeed)
		print("Second Movement Activated")
	
	if global_position.distance_to(startPos) < 1:
		secondMovement = false
	
#	if global_position == targetPos:
#		if global_position == startPos:
#			targetPos = startPos + moveDir
#		else:
#			targetPos = startPos


#func _on_body_entered(body):
#	if body.is_in_group("Player"):
#		body.game_over()

func _on_area_entered(area):
	if area.is_in_group("playerBullet"):
		var bm = boom.instantiate() # Creates an instance of an explosion at the enemy
		bm.set_owner(get_node("../EnemySpwaner"))
		add_sibling(bm)
		bm.play("Boom")
		bm.global_position = global_position
		queue_free()
		
		

