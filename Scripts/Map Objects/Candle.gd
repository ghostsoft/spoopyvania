extends StaticBody2D

export(Array, PackedScene) var dropTable = []

var dead = false
var rng = RandomNumberGenerator.new()

var drop : PackedScene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if(dropTable.size() > 0):
		var i = rng.randi_range(0, dropTable.size()-1)
		drop = dropTable[i]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_hit():
	dead = true
	$Sprite.play("death")
	$CollisionShape2D.set_deferred("disabled", true)
	
	if(drop != null):
		var droppedItem = drop.instance()
		get_parent().add_child(droppedItem)
		droppedItem.global_position = self.global_position

func _on_Sprite_animation_finished():
	if(dead):
		queue_free()
