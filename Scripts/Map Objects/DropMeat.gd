extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var meat : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if(get_child_count() == 0):
		var wallmeat = meat.instance()
		wallmeat.global_position = self.global_position
		get_parent().add_child(wallmeat)
		queue_free()
	
