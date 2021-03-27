extends Node2D

export (Vector2) var player_position = Vector2(0, 2) 
export (int) var att = 0 #attribute of a tower; type of attack/bullet
var att_per_level = 4 #how many towers are available in a level
var total_filaments = [100, 100, 200, 150] #given filaments at the start of the game
var tower_price = [100, 100, 200, 150] # price of each tower

func _ready():
	randomize() #randomizes a number for randi
	
func _process(delta):
	player_move()
	player_build()
	condition()
	
func player_move():  #discrete-like movement of player in a virtual grid
	if Input.is_action_just_pressed("move_right"):
		player_position.x += 1
	if Input.is_action_just_pressed("move_left"):
		player_position.x -= 1
	if Input.is_action_just_pressed("move_down"):
		player_position.y += 1
	if Input.is_action_just_pressed("move_up"):
		player_position.y -= 1
	player_position.x = clamp(player_position.x, 0, 8) #limits player to certain grid
	player_position.y = clamp(player_position.y, 0, 4)
	
func player_build(): #conditions and actions for building towers
	var player = get_node("Player") #checks player position
	if total_filaments[att] >= tower_price[att] and player.is_occupied == false: #checks if enough filaments for chosen tower
		if Input.is_action_just_pressed("build"):
			var tower_scene = preload("res://Tower.tscn") 
			var tower = tower_scene.instance()
			tower.position = Vector2(player.position.x, player.position.y) #places tower on player position
			tower.grid_position = player_position #places tower in player position
			tower.att = att #chosen attribute is tower's attribute
			add_child(tower)
			total_filaments[att] -= tower_price[att] #filaments will be used 
		
	if Input.is_action_just_pressed("switch"): #switches options for towers
		att += 1
		att %= att_per_level

func condition():
	if $Monsters.monsters_dead == $Monsters.monsters.size():
		get_tree().change_scene("res://WinScene.tscn")
		
func _on_Homebase_area_entered(area):
	if "Monster" in area.name:
		get_tree().change_scene("res://GameOver.tscn")
