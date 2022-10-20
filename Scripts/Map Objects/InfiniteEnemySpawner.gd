tool
extends EnemySpawner


export var interval = 2.0
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.connect("timeout", self, "_on_timeout")
	timer.start(interval)

func _on_timeout():	
	if(enabled):
		if not Engine.editor_hint:
			if ($Area2D.get_overlapping_bodies().size() != 0):
				add_child(enemy.instance())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn():
	pass
