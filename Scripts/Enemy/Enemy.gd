class_name Enemy
extends KinematicBody2D

export var health = 1

var sprite : AnimatedSprite

func _ready():
	sprite = find_node("Sprite")

func on_hit() -> void:
	pass
