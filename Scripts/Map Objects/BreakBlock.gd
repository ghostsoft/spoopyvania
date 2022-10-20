extends StaticBody2D

#export var blockTexture: ImageTexture

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var particle : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_hit():
	var brickParticle = particle.instance()
	get_tree().get_root().add_child(brickParticle)
	brickParticle.global_position = self.global_position
	brickParticle.emitting = true
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
