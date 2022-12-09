extends Control

onready var _death_animation = $TextureRect/AnimationPlayer



func _ready():
	

	pass # Replace with function body.

func _on_Player_died():
	_death_animation.play("New Anim")
	pass # Replace with function body.
