extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var camera : Camera2D
var player : Player

export var from = "room1"
export var to = "room2"

signal leaving
signal entering

# Called when the node enters the scene tree for the first time.
func _ready():
	var playerArr = get_tree().get_nodes_in_group("Player")
	if(playerArr.size() != 0):
		player = playerArr[0]
	else:
		print_debug("can't find player")
	#remove_child($Camera2D)
	#player.add_child($Camera2D)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if(player != null):
		$Camera2D.global_position = player.global_position

func _on_Door_body_entered(body):
	if(body.is_in_group("Player")):
		#temporarily switch to door camera
		$Camera2D.current = true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		
		player.pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
		
		#delete all enemies from the previous room
		emit_signal("leaving", from)
		#for i in get_tree().get_nodes_in_group(from):
		#	i.queue_free()
		
		#get_parent().find_node(animationPlayer).play("DoorAnimation")
		player.enter_door()
		$DoorPlayer.play("DoorAnimation")
		
func _on_Door_Finished():
	#set new player camera limits and switch back
	player.get_node("Camera2D").limit_left = $Camera2D.limit_left
	player.get_node("Camera2D").limit_top = $Camera2D.limit_top
	player.get_node("Camera2D").limit_right = $Camera2D.limit_right
	player.get_node("Camera2D").limit_bottom = $Camera2D.limit_bottom
	player.get_node("Camera2D").current = true
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	
	get_tree().paused = false
	player.pause_mode = Node.PAUSE_MODE_INHERIT
	
	# going through door = new checkpoint!
	print_debug("new checkpoint!")
	GameState.set_camera_limits($Camera2D.limit_left,
									$Camera2D.limit_top,
									$Camera2D.limit_right,
									$Camera2D.limit_bottom)
	
	GameState.set_checkpoint(player.global_position)

func _make_visible():
	#makes the enemies in the next room visible
	#for i in get_tree().get_nodes_in_group(to):
	#	i.set_visible(true)
	emit_signal("entering", to)
