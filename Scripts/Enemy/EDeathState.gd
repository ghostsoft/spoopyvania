extends EnemyState

func enter(_msg := {}) -> void:
	enemy.sprite.play("default")
	enemy.velocity = Vector2.ZERO
	enemy.sprite.play("death")
	enemy.isDead = true
	 # warning-ignore:return_value_discarded
	#check if not already connected
	if(!enemy.sprite.is_connected("animation_finished", self, "_on_Sprite_animation_finished")):
		enemy.sprite.connect("animation_finished", self, "_on_Sprite_animation_finished")

func physics_update(_delta: float) -> void:
	pass


func _on_Sprite_animation_finished():
	enemy.sprite.disconnect("animation_finished", self, "_on_Sprite_animation_finished")
	#queue_free()
	enemy.delet()
