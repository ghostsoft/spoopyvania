extends EnemyState



func enter(_msg := {}) -> void:
	enemy.sprite.play("default")
	enemy.velocity = Vector2.ZERO
	enemy.next_decision()

func physics_update(_delta: float) -> void:
	enemy.velocity = enemy.move_and_slide_with_snap(enemy.velocity, Vector2.DOWN, Vector2.UP)
