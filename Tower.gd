extends Area2D

export (Vector2) var grid_position #position in the virtual grid
var health #tower health
var att = 0 #tower attribute; type of attack/bullet 
var add_fil = 50 #returns a number of fill when removed
var bullet_instance
var bullet_texture = preload("res://Bullet.tscn")
var bullet_texture2 = preload("res://Bullet_Orange.tscn")
var bullet_texture3 = preload("res://Bullet_Purple_Down.tscn")
var bullet_texture4 = preload("res://Bullet_Purple_Up.tscn")
var bullet_texture5 = preload("res://Bullet_Purple.tscn")
var bullet_texture6 = preload("res://Bullet_Red.tscn")
var bullet #bullet instance of scene
var bullet2
var bullet3
var parent #get parent

func _ready():
	$Build_Tower.play()
	$Build_Timer.start(0.4)
	match (att): # tower attributes
		0:
			$AnimatedSprite.animation = "build1"
			health = 150
		1:
			$AnimatedSprite.animation = "build2"
			health = 150
		2:
			$AnimatedSprite.animation = "build3"
			health = 150
		3:
			$AnimatedSprite.animation = "build4"
			health = 150

func _process(delta):
	remove()
	switch()

func remove(): #option to remove tower once in the same position as player
	parent = get_parent()
	if parent.player_position == grid_position:
		if Input.is_action_just_pressed("remove"):
			parent.total_filaments[att] += add_fil
			self.queue_free()

func _on_Build_Timer_timeout():
	$Build_Timer.stop()
	match (att):
			0:
				$AnimatedSprite.animation = "tower1"
			1:
				$AnimatedSprite.animation = "tower2"
			2:
				$AnimatedSprite.animation = "tower3"
			3:
				$AnimatedSprite.animation = "tower4"

func switch(): #switches options for towers
	parent = get_parent()
	if att == 1:
		$Bullet_Timer.stop()
		bullet_instance = bullet_texture2
	else:
		$Orange_Bullet_Timer.stop()
		match (att):
			0:
				bullet_instance = bullet_texture
			2:
				bullet_instance = bullet_texture3
				bullet2 = bullet_instance.instance()
				bullet_instance = bullet_texture4
				bullet3 = bullet_instance.instance()
				bullet_instance = bullet_texture5
			3:
				bullet_instance = bullet_texture6
	bullet = bullet_instance.instance()

	match (att):
		0:
			bullet.position = position
		1:
			bullet.position.x = position.x 
			bullet.position.y = position.y - 25
		2:
			bullet.position.x = position.x + 20
			bullet.position.y = position.y - 25
			bullet2.position.x = position.x + 20
			bullet2.position.y = position.y + 55
			bullet3.position.x = position.x + 20
			bullet3.position.y = position.y - 105
		3:
			bullet.position.x = position.x 
			bullet.position.y = position.y - 13
		
func _on_Bullet_Timer_timeout():
	parent.add_child(bullet)
	parent.add_child(bullet2)
	parent.add_child(bullet3)

func _on_Orange_Bullet_Timer_timeout():
	parent.add_child(bullet)
