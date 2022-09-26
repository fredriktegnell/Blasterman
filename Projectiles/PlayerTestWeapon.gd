extends "res://Overlap/Hitbox.gd"

export(int) var speed: int = 200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func destroy():
	queue_free()

func _on_PlayerTestWeapon_area_entered(area):
	destroy()

func _on_PlayerTestWeapon_body_entered(body):
	destroy()
