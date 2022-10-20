extends Area2D

export var steps = 0
export (int, "Left", "Right") var direction = 0
export var ascending = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_start_pos():
	if(direction == 0):
		if(ascending):
			return $StartR.global_position
		else:
			return $StartR.global_position
	elif(direction == 1):
		if(ascending):
			return $StartL.global_position
		else:
			return $StartL.global_position
