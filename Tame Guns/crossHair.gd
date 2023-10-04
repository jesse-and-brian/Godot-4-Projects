extends Area2D

var mousePosition : Vector2
var mouseGlobal : Vector2
@onready var cameraMovement = get_node("../Player").get_child(4) #Child 4 is Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) # hide mouse cursor
	
#func _physics_process(delta):
#	if cameraMovement.
#		position.x = 30

func _process(_delta):
	mousePosition = get_global_mouse_position() # Store global mouse pos inside of mousePosition variable
	position = mousePosition                    # set position of node to mousePosition Vector2 variable
	
