extends Area2D

var tower #area collided = tower 
export (int) var type #store randomized type
var speed #monster speed
var temp_speed #temp store monster speed in case in contact with tower and survives
var health #monster health
var damage #monster damage
var filaments = [0, 0, 0, 0] #types of filaments dropped by monster
var parent

func _ready():
	hide()
	randomize() #randomizes number for randi
	$Collision.disabled = true #collision not allowed until start() is called
	speed = 0
	match (type): #types of monster
		0:
			health = 100
			damage = 50
			filaments[type] = 45
		1:
			health = 100
			damage = 50
			filaments[type] = 45
		2:
			health = 150
			damage = 50
			filaments[type] = 45
		3:
			health = 150
			damage = 50
			filaments[type] = 45
		
func _process(delta):
	position.x -= speed

func start():
	show()
	$Collision.disabled = false #start() is called, collision is visible
	match (type): #types of monster
		0:
			$AnimatedSprite.animation = "monster1"
			$"Monster_Sound(0)".play()
			speed = 0.8
		1:
			$AnimatedSprite.animation = "monster2"
			$"Monster_Sound(1)".play()
			speed = 1
		2:
			$AnimatedSprite.animation = "monster3"
			$"Monster_Sound(2)".play()
			speed = 0.8
		3:
			$AnimatedSprite.animation = "monster4"
			$"Monster_Sound(3)".play()
			speed = 0.8

	temp_speed = speed

func _on_Monster_area_entered(area): 
	if "Tower" in area.name: #tower enters, monster will stay in position, stores area in tower & start timer
		speed = 0
		tower = area
		$Attack_Timer.start(1)
		
func _on_Attack_Timer_timeout(): #attacks monster every x seconds
	if is_instance_valid(tower): #checks if instance is freed; minimize errors
		tower.health -= damage #tower health subtracted by monster damage 
		if tower.health <= 0:
			tower.queue_free()
			$Attack_Timer.stop() #stops timer for attack
			if health > 0: #monster continues when not alive
				speed = temp_speed 
				
func dead(): #called in Bullet; plays dying animation
	parent = get_parent()
	$Dying_Timer.start(1)
	$Attack_Timer.stop()
	speed = 0
	match (type):
		0:
			$AnimatedSprite.animation = "filam1"
		1:
			$AnimatedSprite.animation = "filam2"
		2:
			$AnimatedSprite.animation = "filam3"
		3:
			$AnimatedSprite.animation = "filam4"

func _on_Dying_Timer_timeout(): #animation plays. once timer runs out, queue_free()
	parent.monsters_dead += 1
	self.queue_free()

func _on_Visibility_screen_exited():
	queue_free()
