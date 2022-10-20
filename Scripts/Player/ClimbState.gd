extends State

enum {LEFT, RIGHT}
enum {UP, DOWN}

var ready = false
var stepsFront = 0
var stepsBack = 0
var stairDirection = 0
var ascending = true
var stairPos = Vector2.ZERO

var newPos = Vector2.ZERO

var downDir = 0

var stairSpeed = 40

var playerDirection = 0

var canMove = true

func enter(_msg := {}) -> void:
	if(_msg.has("stair")):
		var stair = _msg.get("stair")
		stairDirection = stair.direction
		ascending = stair.ascending
		stepsFront = stair.steps
		stepsBack = 0
		if(stairDirection == LEFT):
			downDir = 1
		elif(stairDirection == RIGHT):
			downDir = -1
		stairPos = stair.get_start_pos()
		
	else:
		print_debug("no stair object in state message")
		state_machine.transition_to("Idle")
		return

	player.velocity.x = 0
	ready = false

	# setting up for attack animation
	if(!player.get_node("AttackPlayer").is_connected("animation_finished", self, "_attack_finished")):
		# warning-ignore:return_value_discarded
		player.get_node("AttackPlayer").connect("animation_finished", self, "_attack_finished")
	
	newPos = player.position

func physics_update(_delta: float) -> void:
	#if we are not yet on the stair, make sure we get into position
	if(!ready):
		if(player.position != stairPos):
			player.sprite.play("walk")
			if(player.position.x < stairPos.x):
				player.face_right()
			else:
				player.face_left()
			player.position = player.position.move_toward(stairPos, _delta * 20)
		else:
			#we're in position at the very start of the stair
			#newPos = player.position
			if(stairDirection == RIGHT):
				if(ascending):
					player.face_right()
				else:
					player.face_left()
			elif(stairDirection == LEFT):
				if(ascending):
					player.face_left()
				else:
					player.face_right()

			#now to go up or down one step
			#depending on whether the stair is ascending or descending
			if(ascending):
				player.sprite.play("stair_up")
				player.sprite.stop()
				_move_up_step()
				ready = true
			else:
				player.sprite.play("stair_down")
				player.sprite.stop()
				_move_down_step()
				ready = true
			
			#ready = true
	else:
		# we're in position, stair code happens HERE!
		if(player.position != newPos):
			player.position = player.position.move_toward(newPos, _delta * stairSpeed)
		else:
			if(canMove):
				if(stepsBack == 0):
					state_machine.transition_to("Idle")
					return
				elif(stepsFront == 0):
					state_machine.transition_to("Idle")
					return
				
				if(Input.is_action_pressed("ui_right")):
					player.face_right()
					if(stairDirection == RIGHT):
						_move_up_step()
					elif(stairDirection == LEFT):
						_move_down_step()
				
				elif(Input.is_action_pressed("ui_left")):
					player.face_left()
					if(stairDirection == RIGHT):
						_move_down_step()
					elif(stairDirection == LEFT):
						_move_up_step()
				
				elif(Input.is_action_pressed("ui_up")):
					_move_up_step()
					if(stairDirection == RIGHT):
						player.face_right()
					elif(stairDirection == LEFT):
						player.face_left()
				
				elif(Input.is_action_pressed("ui_down")):
					_move_down_step()
					if(stairDirection == RIGHT):
						player.face_left()
					elif(stairDirection == LEFT):
						player.face_right()
		
			#attack code goes here
			if(Input.is_action_just_pressed("attack")):
				# point whip in the right direction
				if(player.facing == player.RIGHT):
					player.get_node("Whip").set_deferred("scale", Vector2(1,1))
				elif(player.facing == player.LEFT):
					player.get_node("Whip").set_deferred("scale", Vector2(-1,1))
				# stop movement
				canMove = false
				if(stairDirection == RIGHT):
					if(playerDirection == UP):
						player.get_node("AttackPlayer").play("AscendAttack")
					else:
						player.get_node("AttackPlayer").play("DescendAttack")
				elif(stairDirection == LEFT):
					if(playerDirection == DOWN):
						player.get_node("AttackPlayer").play("DescendAttack")
					else:
						player.get_node("AttackPlayer").play("AscendAttack")
	
func _move_down_step():
	playerDirection = DOWN
	player.sprite.frame = 0
	player.sprite.play("stair_down")
	#player.sprite.stop()
	newPos = player.position;
	newPos.x += 4 * downDir
	newPos.y += 4
	if(ascending):
		stepsFront += 1
		stepsBack -= 1
	else:
		stepsFront -= 1
		stepsBack += 1

func set_back_steps(number):
	stepsBack = number

func _move_up_step():
	playerDirection = UP
	player.sprite.frame = 0
	player.sprite.play("stair_up")
	#player.sprite.stop()
	newPos = player.position;
	newPos.x -= 4 * downDir
	newPos.y -= 4
	if(ascending):
		stepsFront -= 1
		stepsBack += 1
	else:
		stepsFront += 1
		stepsBack -= 1
	#while(player.position != newPos):
	#	player.sprite.set_frame(1)
	#	player.position = player.position.move_toward(newPos, _delta * 20)

func get_hit(_damageSource):
	#do not transition to knockback state
	#just take some damage :)
	print_debug("ow oof ouch")
	player.get_invulnerability(0.75)

func _attack_finished(_animationName):
	#set the sprite and animation back to standing
	#on stair
	if(playerDirection == DOWN):
		player.sprite.play("stair_down")
		player.sprite.stop()
		player.sprite.frame = 1
		
	elif(playerDirection == UP):
		player.sprite.play("stair_up")
		player.sprite.stop()
		player.sprite.frame = 1
		
	canMove = true

func exit():
	player.get_node("AttackPlayer").disconnect("animation_finished", self, "_attack_finished")
