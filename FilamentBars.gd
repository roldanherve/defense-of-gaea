extends Control

var parent 
var tower_filaments
var att = 0
var att_per_level 

func _ready():
	parent = get_parent()
	tower_filaments = parent.total_filaments
	att_per_level = parent.att_per_level
	att = parent.att
	$Choice1.show()
	$Choice2.hide()
	$Choice3.hide()
	$Choice4.hide()
	$Filled.hide()
	$Filled2.hide()
	$Filled3.hide()
	$Filled4.hide()
	if att_per_level >= 3:
		$Lock.queue_free()
	if att_per_level == 4:
		$Lock2.queue_free()
	
func _process(delta):
	switch()
	$Filaments.value = tower_filaments[0]
	$Filaments2.value = tower_filaments[1]
	if att_per_level >= 3:
		$Filaments3.value = tower_filaments[2]
	if att_per_level == 4:
		$Filaments4.value = tower_filaments[3]
	if $Filaments.value >= 100:
		$Filled.show()
	else:
		$Filled.hide()
	if $Filaments2.value >= 100:
		$Filled2.show()
	else:
		$Filled2.hide()
	if $Filaments3.value >= 100:
		$Filled3.show()
	else:
		$Filled3.hide()
	if $Filaments4.value >= 100:
		$Filled4.show()
	else:
		$Filled4.hide()

func switch():
	if Input.is_action_just_pressed("switch"):
		att += 1
		att %= att_per_level
		match(att):
			0:
				$Filaments.value == tower_filaments[att]
				$Choice1.show()
				$Choice2.hide()
				$Choice3.hide()
				$Choice4.hide()
			1:
				$Filaments2.value == tower_filaments[att]
				$Choice1.hide()
				$Choice2.show()
				$Choice3.hide()
				$Choice4.hide()
			2:
				$Filaments3.value == tower_filaments[att]
				$Choice1.hide()
				$Choice2.hide()
				$Choice3.show()
				$Choice4.hide()
			3:
				$Filaments4.value == tower_filaments[att]
				$Choice1.hide()
				$Choice2.hide()
				$Choice3.hide()
				$Choice4.show()