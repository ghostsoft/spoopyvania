class_name StageManager
extends Node2D

export var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# get ready to load and unload enemies when going through doors
	for i in get_tree().get_nodes_in_group("Door"):
		i.connect("leaving", self, "free_enemies")
		i.connect("entering", self, "spawn_enemies")
	
	# spawn enemies in the first room
	spawn_enemies("Room 1")
	
	# when we enter the level, set this as the current level
	GameState.currentLevel = level
	
	# if we're loading in for the first time, or through game over
	# we set the checkpoint to the original player position and set camera limits
	if(GameState.stageStart):
		GameState.checkpoint = $Player.position
		GameState.set_camera_limits($Player/Camera2D.limit_left,
									$Player/Camera2D.limit_top,
									$Player/Camera2D.limit_right,
									$Player/Camera2D.limit_bottom)
		GameState.stageStart = false
		
	# if we're loading in because of a death we want to move to the last checkpoint
	# and make sure our camera is in the right place
	else:
		$Player.position = GameState.get_checkpoint()
		$Player/Camera2D.limit_left = GameState.cameraLimit_left
		$Player/Camera2D.limit_top = GameState.cameraLimit_top
		$Player/Camera2D.limit_right = GameState.cameraLimit_right
		$Player/Camera2D.limit_bottom = GameState.cameraLimit_bottom

# despawn enemies, deactivate spawners and get rid of projectiles
func free_enemies(room):
	for i in get_tree().get_nodes_in_group(room):
		i.queue_free()
	for i in get_tree().get_nodes_in_group("Projectile"):
		i.queue_free()

# activate enemy spawners in the room
func spawn_enemies(room):
	for i in get_tree().get_nodes_in_group(room):
		i.enable()
		i.spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
