extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	var playerArr = get_tree().get_nodes_in_group("Player")
	if(playerArr.size() != 0):
		player = playerArr[0]
		get_parent().call_deferred("remove_child", self)
		player.call_deferred("add_child", self)
	else:
		print_debug("can't find player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
