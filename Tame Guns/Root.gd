extends Node2D

var cameraPosition :  Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _physics_process(delta):
	cameraPosition = $Player/Camera.get_target_position()
	#print(cameraPosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
