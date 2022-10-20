extends Node2D

export(Array, PackedScene) var levels


const maxPlayerHealth = 10
var playerHealth = 10
var playerLives = 3
var playerHearts = 0

var stageStart = true

var checkpoint = Vector2.ZERO

var currentLevel = 0

var cameraLimit_left
var cameraLimit_top
var cameraLimit_right
var cameraLimit_bottom

func set_lives(lives):
	playerLives = lives
	
func get_lives():
	return playerLives

func get_level(index):
	return levels[index]

func set_checkpoint(newCheckpoint):
	checkpoint = newCheckpoint

func get_checkpoint():
	return checkpoint

func set_camera_limits(left, top, right, bottom):
	cameraLimit_left = left
	cameraLimit_top = top
	cameraLimit_right = right
	cameraLimit_bottom = bottom
