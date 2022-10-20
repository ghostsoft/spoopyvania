extends CanvasLayer

export var playerHP : Texture
export var enemyHP : Texture
export var emptyHP : Texture

var maxEnemyHealth = 10
var enemyHealth = 10

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$LifeCounter.text = str("%02d" % GameState.get_lives())
	var playerArr = get_tree().get_nodes_in_group("Player")
	if(playerArr.size() != 0):
		player = playerArr[0]
# warning-ignore:return_value_discarded
		player.connect("health_changed", self, "_update_player_health")
# warning-ignore:return_value_discarded
		player.connect("hearts_changed", self, "_update_hearts")
	else:
		print_debug("can't find player")

func _update_hearts(value):
	$HeartCounter.text = str("%02d" % value)

func _update_player_health():
	var GUI = $PlayerHP
	for i in GUI.get_child_count():
		if GameState.playerHealth > i:
			GUI.get_child(i).texture = playerHP
		else:
			GUI.get_child(i).texture = emptyHP

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
