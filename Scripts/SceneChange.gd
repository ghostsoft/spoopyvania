extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var nextScene : String
export var nextSceneIndex = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if(body.is_in_group("Player")):
		print_debug("touched loading zone")
		get_tree().paused = true
		GameState.currentLevel = nextSceneIndex
		get_tree().change_scene(nextScene)
		
	pass
