extends Control

onready var _death_animation = $TextureRect/AnimationPlayer



func _ready():
	_death_animation.play("New Anim")

	pass # Replace with function body.

func _on_Player_died():
	_death_animation.play("New Anim")
	pass # Replace with function body.


func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
