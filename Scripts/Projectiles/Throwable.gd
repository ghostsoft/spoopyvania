extends Node2D


var direction = 0
var strength = 0
var velocity = Vector2.ZERO

func init(velocityVector, dir):
	direction = dir
	velocity.x = velocityVector.x * direction
	velocity.y = velocityVector.y

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timeout")
	timer.start(2.5)

func _on_timeout():
	#delete urself
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):	
	position = position + velocity * _delta
