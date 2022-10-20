class_name EnemySpawner
tool
extends Node2D

export var enemy : PackedScene setget set_enemy

var enabled = false

func set_enemy(new_value):
	enemy = new_value
	if Engine.editor_hint:
		if(has_node("Sprite")):
			get_node("Sprite").queue_free()
		var temp = enemy.instance()
		add_child(temp.get_node("Sprite").duplicate())
		temp.queue_free()
		
func enable():
	enabled = true

func spawn():
	if(enabled):
		if not Engine.editor_hint:
			add_child(enemy.instance())

func _process(_delta):
	pass
