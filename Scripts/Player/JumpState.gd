extends State

enum {NONE, RIGHT, LEFT}

var dir = NONE

func enter(_msg := {}) -> void:
	player.sprite.play("crouch")
	if(Input.is_action_pressed("ui_right")):
		#player.velocity.x = player.SPEED
		dir = RIGHT
		player.face_right()
	elif(Input.is_action_pressed("ui_left")):
		#player.velocity.x = -player.SPEED
		dir = LEFT
		player.face_left()
	else:
		dir = NONE
	
	player.velocity.y = player.JUMP_POWER

func physics_update(_delta: float) -> void:
	match(dir):
		NONE:
			player.velocity.x = 0
		RIGHT:
			player.velocity.x = player.SPEED
		LEFT:
			player.velocity.x = -player.SPEED
	
	if(player.velocity.y < 50 && player.velocity.y > -50):
		player.velocity.y += (player.GRAVITY)/2.0
	else:
		player.velocity.y += player.GRAVITY
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if(player.is_on_floor()):
		state_machine.transition_to("Idle")
		return
	
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
		return
	
	return

func get_hit(_enemy):
	#transition to knockback state
	state_machine.transition_to("Knockback", {"enemy" : _enemy})
	return
