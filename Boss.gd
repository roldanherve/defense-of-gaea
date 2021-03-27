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
	health = 500
	damage = 75
	filaments[type] = 0
		
func _process(delta):
	position.x -= speed

func start():
	show()
	$Collision.disabled = false #start() is called, collision is visible
	speed = 0.5
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

func _on_Dying_Timer_timeout(): #animation plays. once timer runs out, queue_free()
	parent.monsters_dead += 1
	self.queue_free()

func _on_Visibility_screen_exited():
	queue_free()
