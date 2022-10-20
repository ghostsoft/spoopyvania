extends State

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.sprite.play("idle")

func physics_update(_delta: float) -> void:
	
	player.velocity = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN, Vector2.UP)
	
	if(!player.is_on_floor()):
		state_machine.transition_to("Fall")
		return
	
	if(Input.is_action_just_pressed("jump")):
		state_machine.transition_to("Jump")
		return
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.transition_to("Walk")
		return
	
	if(Input.is_action_pressed("ui_up")):
		var stair = player.get_ascending_stair()
		if(stair != null):
			state_machine.transition_to("Climb", {"stair" : stair})
			return
		elif Input.is_action_just_pressed("attack"):
			player.throw_subweapon()
	elif(Input.is_action_pressed("ui_down")):
		var stair = player.get_descending_stair()
		if(stair != null):
			state_machine.transition_to("Climb", {"stair" : stair})
			return
	
	
	if Input.is_action_pressed("ui_down"):
		player.sprite.play("crouch")
		player.get_node("StandingHitbox").set_deferred("disabled", true)
		player.get_node("CrouchingHitbox").set_deferred("disabled", false)
		
		if Input.is_action_just_pressed("attack"):
			state_machine.transition_to("Attack", {"pose" : "crouching"})
			return
	else:
		player.get_node("StandingHitbox").set_deferred("disabled", false)
		player.get_node("CrouchingHitbox").set_deferred("disabled", true)
		player.sprite.play("idle")
		
		if Input.is_action_just_pressed("attack"):
			state_machine.transition_to("Attack", {"pose" : "standing"})
			return

func get_hit(_damageSource):
	#transition to knockback state
	state_machine.transition_to("Knockback", {"damageSource" : _damageSource})
	return
