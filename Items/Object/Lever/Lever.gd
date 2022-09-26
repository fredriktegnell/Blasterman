extends Area2D

onready var _animated_sprite = $AnimatedSprite
var inside = false
export(int) var damage: int = 0


func _on_Lever_area_entered(area: Area2D)->bool:
	inside = true
	return inside


func _on_Lever_area_exited(area:Area2D)->bool:
	inside = false
	return inside


func _input(event):
	
	if inside == true:
		if event is InputEventKey and event.pressed:
			if event.scancode == KEY_SPACE and _animated_sprite.frame == 0:
				_animated_sprite.frame = 1

			elif  event.scancode == KEY_SPACE and _animated_sprite.frame == 1:
				_animated_sprite.frame = 0
				
				
				
			
	
	
