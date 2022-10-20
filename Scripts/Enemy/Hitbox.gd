class_name Hitbox
extends Area2D

export var damage = 1
var overlapping

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_nodes_in_group("Player")
	if(player.size() != 0):
		player[0].connect("invuln_ended", self, "_on_Hitbox_overlap")
	else:
		print_debug("can't find player")
	# warning-ignore:return_value_discarded
	self.connect("body_entered", self, "_on_Hitbox_body_entered")

func _on_Hitbox_body_entered(body):
	if(body.get_name() == "Player"):
		body.get_hit(self)

func _on_Hitbox_overlap():
	overlapping = get_overlapping_bodies()
	if(overlapping.size() > 0):
		for o in overlapping:
			if(o.is_in_group("Player")):
				o.get_hit(self)
