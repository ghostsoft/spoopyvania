class_name Player
extends KinematicBody2D

const GRAVITY = 20
const SPEED = 60
const JUMP_POWER = -250

var velocity = Vector2.ZERO

enum {LEFT, RIGHT}
var facing = RIGHT

onready var sprite = get_node("PlayerSprite")

var invulnerable = false
var hearts = 0

signal invuln_ended
signal health_changed
signal hearts_changed

export(Array, PackedScene) var subWeapons

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	add_to_group("Player")

func _ready():
	emit_signal("health_changed")

func _process(_delta):
	$StateMachine.update(_delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$StateMachine.physics_update(_delta)

func get_ascending_stair():
	var stairs = $StairMaster.get_overlapping_areas()
	if(stairs.size() == 0):
		return null
	elif(stairs.size() > 2):
		print_debug("too many stairs!!!!")
		return null
	else:
		for stair in stairs:
			if(stair.ascending == true):
				return stair
		return null

func get_descending_stair():
	var stairs = $StairMaster.get_overlapping_areas()
	if(stairs.size() == 0):
		return null
	elif(stairs.size() > 2):
		print_debug("too many stairs!!!!")
		return null
	else:
		for stair in stairs:
			if(stair.ascending == false):
				return stair
		return null

func face_left():
	facing = LEFT
	sprite.flip_h = false
	
func face_right():
	facing = RIGHT
	sprite.flip_h = true

func get_hit(damageSource : Hitbox):
	if(!invulnerable):
		set_health(GameState.playerHealth - damageSource.damage)
		#print_debug("player now has "+ str(GameState.playerHealth)+" health")
		if(GameState.playerHealth <= 0):
			die()
		$StateMachine.state.get_hit(damageSource)
		#emit_signal("update_health", damageSource.damage)

func fall_out():
	GameState.playerHealth = 0
	emit_signal("health_changed")
	die()

func get_healed(amount):
	set_health(GameState.playerHealth + amount)

func get_invulnerability(time):
	invulnerable = true
	$InvulnPlayer.play("Invulnerable")
	yield(get_tree().create_timer(time), "timeout")
	invulnerable = false
	$InvulnPlayer.seek(0, true)
	$InvulnPlayer.stop(true)
	$PlayerSprite.visible = true
	emit_signal("invuln_ended")

func get_heart(value):
	hearts += value
	emit_signal("hearts_changed", hearts)

func enter_door():
	$StateMachine.transition_to("Door")

func die():
	# :)
	invulnerable = true
	$StateMachine.transition_to("Death")
	GameState.set_lives(GameState.get_lives()-1)
	yield(get_tree().create_timer(2), "timeout")
	GameState.playerHealth = GameState.maxPlayerHealth
	if(GameState.get_lives() == 0):
		#game over :)
		pass
	else:
		#respawn :)
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(GameState.get_level(GameState.currentLevel))
		set_health(GameState.maxPlayerHealth)
		invulnerable = false
	
func set_health(value):
	GameState.playerHealth = clamp(value, 0, GameState.maxPlayerHealth)
	emit_signal("health_changed")

func throw_subweapon():
	var wep = subWeapons[0].instance()
	get_tree().get_root().add_child(wep)
	wep.global_position = self.global_position
	wep.position.y -= 8
	wep.position.x += 5
	wep.init(Vector2(200,0), 1)
