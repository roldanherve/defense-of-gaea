extends Area2D

var monster
var damage = 25
var chance

func _ready():
	randomize()
	chance = randi()%3
	$Shot_Sound.play()

func _process(delta):
	position.x += 1.5

func _on_Bullet_Red_area_entered(area):
	monster = area
	if monster.type == 3:
		if chance > 0:		
			monster.health -= damage
	else:
		monster.health -= damage
	if monster.speed >= 0.3:
		$Timer.start(2.5)
		monster.speed -= (monster.speed * 0.5)
	if monster.health <= 0:
		monster.dead()
		var parent = get_parent()
		var x = monster.type
		var filament = monster.filaments[x]
		parent.total_filaments[x] += filament
	self.queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()

func _on_Timer_timeout():
	monster.speed = monster.temp_speed 
