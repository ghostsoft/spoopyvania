extends EnemyState

var jumpDir = 0

func enter(_msg := {}) -> void:
	if(_msg.has("direction")):
		jumpDir = _msg.get("direction")
	
	enemy.sprite.play("default")	
	enemy.velocity.y = enemy.JUMP_POWER


func physics_update(_delta: float) -> void:
	enemy.velocity.x = enemy.SPEED * jumpDir
	
	if(enemy.velocity.y < 50 && enemy.velocity.y > -50):
		enemy.velocity.y += (enemy.GRAVITY)/2.0
	else:
		enemy.velocity.y += enemy.GRAVITY
	
	enemy.velocity = enemy.move_and_slide(enemy.velocity, Vector2.UP)
	
	if(enemy.is_on_floor()):
		state_machine.transition_to("Thinking")
		return
