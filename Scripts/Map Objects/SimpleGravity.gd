extends KinematicBody2D


export var maxVelocity = 300
export var gravity = 10

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if(velocity.y + gravity < maxVelocity):
		velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
