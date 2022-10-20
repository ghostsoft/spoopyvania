extends Enemy


export var magnitude = -24

var origX = 0
var player
var direction = 0
var offsetY = 0

var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	alive = true
	
# warning-ignore:return_value_discarded
	$VisibilityNotifier2D.connect("screen_exited", self, "_screen_exit")
	
	var playerGrp = get_tree().get_nodes_in_group("Player")
	if(playerGrp.size() != 0):
		player = playerGrp[0]
	else:
		print_debug("can't find player")
	if(player.facing == player.RIGHT):
		global_position.x = player.get_node("Camera2D").get_camera_screen_center().x+80
		direction = -1
		$Sprite.flip_h = false
	else:
		global_position.x = player.get_node("Camera2D").get_camera_screen_center().x-80
		direction = 1
		$Sprite.flip_h = true
	
	origX = global_position.x
	offsetY = player.global_position.y-8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(alive):
		global_position.x += (direction * 48) * delta
		global_position.y = magnitude * cos(((global_position.x - origX)/120)*(2*PI)) + offsetY

func _screen_exit():
	# if not on screen, despawn
	#if(!$VisibilityNotifier2D.is_on_screen()):
	#print_debug(global_position)
	queue_free()

func on_hit():
	alive = false
	$Sprite.play("death")
	 # warning-ignore:return_value_discarded
	#check if not already connected
	if(!$Sprite.is_connected("animation_finished", self, "_on_Sprite_animation_finished")):
		$Sprite.connect("animation_finished", self, "_on_Sprite_animation_finished")

func _on_Sprite_animation_finished():
	$Sprite.disconnect("animation_finished", self, "_on_Sprite_animation_finished")
	queue_free()
