extends KinematicBody2D


export var idle_duration = 1.0
export var speed = 15
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = $Tween

export var endPos : Vector2

var startPos = Vector2.ZERO

var follow = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	follow = self.global_position
	startPos = self.global_position
	endPos = self.global_position + endPos
	var duration = endPos.length() / speed
	tween.interpolate_property(self, "follow", startPos, endPos, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle_duration)
	tween.interpolate_property(self, "follow", endPos, startPos, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + idle_duration * 2)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	self.position = self.position.linear_interpolate(follow, 0.075)
