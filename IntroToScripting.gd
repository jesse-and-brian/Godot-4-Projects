extends Node2D

var score : int = 81
var moveSpeed : float = 2.53
var gameOver : bool = true
var ability : String = "slash"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	# Printing out the variable being declared here that the function _add is number crunching
	var results = _add(10, 25)
	print(results)
	
	if score == 10:
		print("You Win")
		
	if score >= 5:
		print("Score is greater than 5")
	
	# operators example
	moveSpeed = 5.1
	moveSpeed += 1
	moveSpeed -= 2
	moveSpeed *= 10
	moveSpeed /= 2
	print(moveSpeed)
	
	_welcomeMessage()
	
	ability += " now"
	print(ability)
	ability += " I'm surprised this works."
	print(ability)
	
	# Else if statement example
	if score > 80:
		print("A")
	elif score > 60:
		print("B")
	elif score >= 10:
		print("C")
	else:
		print("D")

# Takes two inputs, does the math, then returns it back
func _add (a, b):
	var sum = a + b
	return sum

func _welcomeMessage():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_welcomeMessage()
