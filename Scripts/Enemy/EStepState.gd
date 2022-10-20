extends EnemyState

var stepDir = 0
var newPos = Vector2.ZERO

var stepSize = 16

func enter(_msg := {}) -> void:
	if(_msg.has("direction")):
		stepDir = _msg.get("direction")
	enemy.sprite.play("default")	
	enemy.velocity = Vector2.ZERO
	
	newPos = enemy.position
	newPos.x += (stepSize * stepDir)
	
	if(stepDir == 1):
		enemy.raycast.position.x = 4
	elif(stepDir == -1):
		enemy.raycast.position.x = -3
	
	#enemy.position.y = enemy.position.y - 100
	#print_debug("new pos x is " + str(newPos.x))
	#enemy.velocity.x = enemy.SPEED * stepDir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta):
	if(enemy.get_node("RayCast2D").is_colliding() == false):
		state_machine.transition_to("Thinking")
		return
	if(enemy.position != newPos):
		#if(!enemy.test_move(enemy.transform, enemy.position.move_toward(newPos, _delta * enemy.SPEED))):
		if(!enemy.test_move(enemy.transform, Vector2.RIGHT * stepDir)):
			enemy.position = enemy.position.move_toward(newPos, _delta * enemy.SPEED)
		else:
			state_machine.transition_to("Thinking")
			return
		#enemy.velocity = enemy.move_and_slide_with_snapenemy.velocity, Vector2.DOWN, Vector2.UP)
	else:
		state_machine.transition_to("Thinking")
		return
