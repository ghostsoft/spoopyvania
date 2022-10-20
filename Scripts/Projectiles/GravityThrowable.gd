extends Node2D


const GRAVITY = 10
const MAXVELOCITY = 150

var direction = 0
var strength = 0
var velocity = Vector2.ZERO

var drag = 0.5

func init(strengthVector, dir):
	direction = dir
	strength = strengthVector.x
	velocity.x = strength * direction
	velocity.y = strengthVector.y

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timeout")
	timer.start(2.5)
	#yield(get_tree().create_timer(2.5), "timeout")
	#queue_free()

func _on_timeout():
	#delete urself
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#velocity.x -= (drag * _delta)*direction
	velocity.x -= (drag * velocity.x * _delta)
	if(velocity.y + GRAVITY < MAXVELOCITY):
		if(velocity.y < 50 && velocity.y > -50):
			velocity.y += (GRAVITY)/4.0
		else:
			velocity.y += GRAVITY
	
	position = position + velocity * _delta
