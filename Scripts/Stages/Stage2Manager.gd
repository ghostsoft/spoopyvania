extends StageManager

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.face_left()
	#$Player.position = Vector2(20, 128)
	#$Player/StateMachine.transition_to("Climb", {"stair" : $Stairs/Stair1})
	#yield(get_tree().create_timer(0.5), "timeout")
	#$Player/StateMachine/Climb._move_up_step()
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
