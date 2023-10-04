extends Area2D

var mousePosition : Vector2
var mouseGlobal : Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) # hide mouse cursor
	
func _physics_process(delta):
	pass

func _process(delta):
	mousePosition = get_global_mouse_position() - get_node("../").cameraPosition # Store global mouse pos inside of mousePosition variable
	global_position = mousePosition                    # set position of node to mousePosition Vector2 variable
	
