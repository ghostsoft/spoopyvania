extends KinematicBody2D


var swingFreq = 5
var swingAmp = 32
var fallSpeed = 15

var time = 0

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = fallSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if(!is_on_floor()):
		time += _delta
		velocity.x = cos(time * swingFreq) * swingAmp
		
		velocity = move_and_slide(velocity, Vector2.UP)
