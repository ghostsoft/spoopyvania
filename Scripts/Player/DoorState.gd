extends State

var waitTime = 3
var wait = true

var newPos = Vector2.ZERO

func enter(_msg := {}) -> void:
	wait = true
	player.sprite.play("idle")
	player.velocity = Vector2.ZERO
	newPos = player.position
	newPos.x += 40

func physics_update(_delta: float) -> void:
	player.velocity = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN, Vector2.UP)
	if(wait):
		yield(get_tree().create_timer(waitTime), "timeout")
		wait = false
	else:
		player.sprite.play("walk")
		player.position = player.position.move_toward(newPos, _delta * player.SPEED)
		
		if(player.position.distance_to(newPos) < 0.1):
			player.sprite.play("idle")
			yield(get_tree().create_timer(0.7), "timeout")
			state_machine.transition_to("Idle")
