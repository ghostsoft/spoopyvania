extends State

var direction = Vector2.ZERO
export var knockbackHeight = -120
export var knockbackLength = 30

func enter(_msg := {}) -> void:
	player.sprite.play("knockback")
	player.invulnerable = true

	if(_msg.has("damageSource")):
		var damageSource = _msg.get("damageSource")
		if(player.global_position.x > damageSource.global_position.x):
			direction = 1
		else:
			direction = -1
	else:
		direction = -1
	
	player.velocity.x = knockbackLength * direction
	player.velocity.y = knockbackHeight

func physics_update(_delta: float) -> void:

	if(player.velocity.y < 50 && player.velocity.y > -50):
		player.velocity.y += (player.GRAVITY)/5.0
	else:
		player.velocity.y += player.GRAVITY
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if(player.is_on_floor()):
		state_machine.transition_to("Idle")
		player.get_invulnerability(0.75)
		return

