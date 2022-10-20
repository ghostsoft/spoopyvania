extends State

var pose

func enter(_msg := {}) -> void:
	if(_msg.has("pose")):
		pose = _msg.get("pose")
	else:
		pose = "standing"
	
	if(!player.get_node("AttackPlayer").is_connected("animation_finished", self, "_attack_finished")):
		# warning-ignore:return_value_discarded
		player.get_node("AttackPlayer").connect("animation_finished", self, "_attack_finished")
	
	if(player.facing == player.RIGHT):
		player.get_node("Whip").set_deferred("scale", Vector2(1,1))
	elif(player.facing == player.LEFT):
		player.get_node("Whip").set_deferred("scale", Vector2(-1,1))
	
	match(pose):
		"standing":
			player.get_node("AttackPlayer").play("Attack")
		"crouching":
			player.get_node("AttackPlayer").play("CrouchAttack")
	

func physics_update(_delta: float) -> void:
	if(player.is_on_floor()):
		player.velocity = Vector2.ZERO
		player.velocity = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN, Vector2.UP)
		return
	
	if(player.velocity.y < 50 && player.velocity.y > -50):
		player.velocity.y += (player.GRAVITY)/2.0
	else:
		player.velocity.y += player.GRAVITY
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	#pass

func _attack_finished(_animationName):
	state_machine.transition_to("Idle")
	return

func get_hit(_enemy):
	#transition to knockback state
	
	player.get_node("Whip").get_node("WhipSprite").set_visible(false)
	player.get_node("Whip").get_node("WhipHitbox").set_deferred("disabled", true)
	player.get_node("Whip").get_node("WhipBackHitbox").set_deferred("disabled", true)
	player.get_node("AttackPlayer").stop(true)
	
	state_machine.transition_to("Knockback", {"enemy" : _enemy})
	return

func exit():
	player.get_node("AttackPlayer").disconnect("animation_finished", self, "_attack_finished")
