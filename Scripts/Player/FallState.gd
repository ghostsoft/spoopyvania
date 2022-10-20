extends State

func enter(_msg := {}) -> void:
	player.sprite.play("crouch")
	player.velocity.x = 0

func physics_update(_delta: float) -> void:

	if(player.is_on_floor()):
		state_machine.transition_to("Idle")
		return

	player.velocity.y += player.GRAVITY
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func get_hit(_damageSource):
	#transition to knockback state
	state_machine.transition_to("Knockback", {"damageSource" : _damageSource})
	return
