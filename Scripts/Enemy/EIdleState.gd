extends EnemyState

var waiting = false
var timer

func enter(_msg := {}) -> void:
	enemy.velocity = Vector2.ZERO
	enemy.sprite.play("default")
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(1)
	timer.connect("timeout", self, "_done_waiting")

func physics_update(_delta: float) -> void:
	enemy.velocity = enemy.move_and_slide_with_snap(enemy.velocity, Vector2.DOWN, Vector2.UP)

	if(!enemy.is_on_floor()):
		state_machine.transition_to("Fall")
		return
	
#	if(Input.is_action_just_pressed("jump")):
#		state_machine.transition_to("Jump", {"direction" : 1})
#		return
#
#
#	if(Input.is_action_pressed("ui_left")):
#		state_machine.transition_to("Step", {"direction" : -1})
#	elif(Input.is_action_pressed("ui_right")):
#		state_machine.transition_to("Step", {"direction" : 1})
func exit() -> void:
	timer.stop()
	timer.disconnect("timeout", self, "_done_waiting")
	timer.queue_free()

func _done_waiting():
	state_machine.transition_to("Thinking")
