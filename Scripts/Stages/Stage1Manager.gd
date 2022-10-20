extends StageManager

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player/StateMachine.transition_to("Climb", {"stair" : $Stairs/Stair5})
	#yield(get_tree().create_timer(0.5), "timeout")
	#$Player/StateMachine/Climb.set_back_steps(2)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
