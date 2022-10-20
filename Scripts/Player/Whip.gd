extends Area2D

export var hitFX : PackedScene

var space_state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	space_state = get_world_2d().direct_space_state


func _on_Whip_body_entered(body):
	var fx = hitFX.instance()
	body.add_child(fx)
	
	var raycastResult = space_state.intersect_ray(self.global_position, body.global_position, [self], collision_mask)
	fx.global_position = raycastResult.get("position")
	
	yield(get_tree().create_timer(.1), "timeout")
	fx.queue_free()
	body.on_hit()
	#queue_free()
