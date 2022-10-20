extends Area2D


export var healValue = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore:return_value_discarded
	self.connect("body_entered", self, "_on_Hitbox_body_entered")

func _on_Hitbox_body_entered(body):
	if(body.get_name() == "Player"):
		body.get_healed(healValue)
		get_parent().queue_free()
