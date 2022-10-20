extends State

var knockback = false
var knockbackDirection = 0
var knockbackPower = 100

func enter(_msg := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	if(!player.is_on_floor()):
		state_machine.transition_to("Fall")
		return
		
	
	if(player.is_on_floor()):
		knockback = false
	if(Input.is_action_pressed("ui_right")):
		player.velocity.x = player.SPEED
		player.sprite.play("walk")
		player.face_right()
	elif(Input.is_action_pressed("ui_left")):
		player.velocity.x = -player.SPEED
		player.sprite.play("walk")
		player.face_left()
	else:
		state_machine.transition_to("Idle")
		return
	
	if(Input.is_action_just_pressed("jump")):
		state_machine.transition_to("Jump")
		return
	
	if Input.is_action_just_pressed("attack"):
		player.velocity = Vector2.ZERO
		state_machine.transition_to("Attack")
		return
	
	player.velocity.y += player.GRAVITY
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func get_hit(_damageSource):
	#transition to knockback state
	state_machine.transition_to("Knockback", {"damageSource" : _damageSource})
	return
