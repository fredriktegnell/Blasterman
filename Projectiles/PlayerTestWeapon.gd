extends "res://Overlap/Hitbox.gd"

export(int) var speed: int = 200

var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction

func destroy():
	queue_free()

func _on_PlayerTestWeapon_area_entered(area):
	destroy()

func _on_PlayerTestWeapon_body_entered(body):
	destroy()
