extends Node2D
var rand_pos
var monsters
var monsters_dead = 0
var i = 0

func _ready():
	monsters = get_tree().get_nodes_in_group("monster") #array of monsters
	$Grace_Timer.start(7)
	
func _on_Grace_Timer_timeout():
	$Grace_Timer.stop()
	$Timer.start(3)

func _process(delta):
	if monsters_dead == monsters.size():
		pass

func _on_Timer_timeout():
	if i == monsters.size():
		$Timer.stop()
	else:
		rand_pos = randi()%5
		match (rand_pos):
			0:
				monsters[i].position = Vector2(990, 140)
			1:
				monsters[i].position = Vector2(990, 220)
			2:
				monsters[i].position = Vector2(990, 300)
			3:
				monsters[i].position = Vector2(990, 380)
			4:
				monsters[i].position = Vector2(990, 440)
		monsters[i].start()
		i += 1