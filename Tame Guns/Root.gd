extends Node2D

var cameraPosition :  Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#cameraPosition = get.child(1).get.child(4).get_target_position() #Child 4 is Camera
	cameraPosition = $Player/Camera.get_target_position()
	print(cameraPosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
