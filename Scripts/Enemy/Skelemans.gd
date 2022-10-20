extends Enemy


const GRAVITY = 8
const MAXVELOCITY = 100
const JUMP_POWER = -200

const SPEED = 20

var direction = -1

var minBoneTime = 0.2
var maxBoneTime = 2
var isDead = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO

export var bone : PackedScene

onready var raycast = get_node("RayCast2D")
onready var bonetimer = get_node("BoneTimer")

var rng = RandomNumberGenerator.new()

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var playerArr = get_tree().get_nodes_in_group("Player")
	if(playerArr.size() != 0):
		player = playerArr[0]
	else:
		print_debug("can't find player")
	
	bonetimer.connect("timeout", self, "_throw_bone")

func _process(_delta):
	$StateMachine.update(_delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$StateMachine.physics_update(_delta)
	
	# always face the player
	if(player != null):
		if(player.global_position.x > self.global_position.x):
			direction = 1
			sprite.flip_h = true
		else:
			direction = -1
			sprite.flip_h = false
	
#	if(Input.is_action_just_pressed("attack")):
#		var projectile = bone.instance()
#		get_tree().get_root().add_child(projectile)
#		projectile.global_position = self.global_position
#		projectile.position.y -= 6
#		projectile.init(Vector2(rng.randi_range(30,50), rng.randi_range(-150, -250)), -1)
	pass

func next_decision():
	var i = rng.randi_range(0,4)
	#print_debug("thinking :)")
	match(i):
		0:
			$StateMachine.transition_to("Idle")
			return
		1:
			$StateMachine.transition_to("Step", {"direction" : 1})
			return
		2:
			$StateMachine.transition_to("Step", {"direction" : -1})
			return
		3:
			$StateMachine.transition_to("Jump", {"direction" : 1})
			return
		4:
			$StateMachine.transition_to("Jump", {"direction" : -1})
			return

func on_hit():
	health -= 1
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	
	$StateMachine.transition_to("Death")

func delet():
	queue_free()

func _throw_bone():
	bonetimer.start(rng.randf_range(minBoneTime, maxBoneTime))
		
	if($VisibilityNotifier2D.is_on_screen() && !isDead):
		var projectile = bone.instance()
		get_tree().get_root().add_child(projectile)
		projectile.global_position = self.global_position
		projectile.position.y -= 6
		projectile.init(Vector2(rng.randi_range(30,50), rng.randi_range(-150, -250)), direction)
