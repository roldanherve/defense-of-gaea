extends Area2D

var is_occupied = false

export (int) var speed_x = 90 #distance per step/grid
export (int) var speed_y = 80

func _process(delta):
	movement()

func movement(): #discrete-like movement of player
	if Input.is_action_just_pressed("move_right"):
		position.x += speed_x
	if Input.is_action_just_pressed("move_left"):
		position.x -= speed_x
	if Input.is_action_just_pressed("move_down"):
		position.y += speed_y
	if Input.is_action_just_pressed("move_up"):
		position.y -= speed_y
	position.x = clamp(position.x, 180, 900) #limits player to a certain grid
	position.y = clamp(position.y, 140, 460)

func _on_Player_area_entered(area):
	if "Tower" in area.name:
		is_occupied = true

func _on_Player_area_exited(area):
	if "Tower" in area.name:
		is_occupied = false
