extends Sprite2D



	
# Called when the node enters the scene tree for the first time.
func _ready():
	# Vector2 stores xy pos values, Vector3 includes z for 3-D space
	
	var vec = Vector2(500,200)
	global_position = vec
	
var timer : float = 0.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer += 1.0 * delta
	print(timer)
	
	var direction = Vector2(1,1)
	# multiplying by delta makes it per second instead of per frame (which would be influenced by a higher frame rate) This moves 30 pixels per second
	global_position += direction * 30 * delta
