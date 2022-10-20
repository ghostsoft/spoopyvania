extends EnemyState

func enter(_msg := {}) -> void:
	enemy.sprite.play("default")
	enemy.velocity.x = 0

func physics_update(_delta: float) -> void:

	if(enemy.is_on_floor()):
		state_machine.transition_to("Thinking")
		return

	#enemy.velocity.y += enemy.GRAVITY
	if(enemy.velocity.y + enemy.GRAVITY < enemy.MAXVELOCITY):
		enemy.velocity.y += enemy.GRAVITY
	
	enemy.velocity = enemy.move_and_slide(enemy.velocity, Vector2.UP)
