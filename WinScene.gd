extends Node2D

func _ready():
	$Timer.start(2)

func _on_Timer_timeout():
	$Timer.stop()
	get_tree().change_scene("res://TitleScreen.tscn")
