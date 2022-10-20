extends State

var hasLanded = false

func enter(_msg := {}) -> void:
	player.invulnerable = true
	player.sprite.play("knockback")
	hasLanded = false

func physics_update(_delta: float) -> void:
	player.velocity = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN, Vector2.UP)
	
	player.velocity.y += player.GRAVITY
	
	if(player.is_on_floor() && !hasLanded):
		player.velocity.x = 0
		player.sprite.play("death")
		hasLanded = true
