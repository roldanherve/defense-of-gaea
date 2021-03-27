extends Area2D

var monster
var damage = 25
var chance

func _ready():
	randomize()
	chance = 0
	$Timer.start(1)
	$Shot_Sound.play()
	$AnimatedSprite.animation = "blank"
	$AnimatedSprite2.animation = "default"
	
func _process(delta):
	position.x += 1.5

func _on_Bullet_Purple_area_entered(area):
	monster = area
	monster.health -= damage 
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
	$Timer.stop()
	$AnimatedSprite.animation = "default"
	$AnimatedSprite2.hide()