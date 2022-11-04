extends Node2D

onready var _animation = $AnimationPlayer

func _ready():
	_animation.play("idle")
	
	pass # Replace with function body.



func _on_Area2D_area_entered(area):
	print("AJ")
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	pass # Replace with function body.
