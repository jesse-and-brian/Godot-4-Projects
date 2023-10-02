extends Area2D

var bobHeight : float = 5
var bobSpeed : float = 5
var time : float = 0

@onready var startYPos : float = global_position.y



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var d = (sin(time * bobSpeed + 1)/2)
	global_position.y = startYPos + (d * bobHeight)
	


func _on_body_entered(body):
		if body.is_in_group("Player"):
			body.add_score(1)
			queue_free()
