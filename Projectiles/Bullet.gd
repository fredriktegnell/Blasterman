extends "res://Overlap/Hitbox.gd"

export(int) var speed: int = 200

var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity * delta
	
func set_direction(direction: Vector2):
	self.direction = direction
	self.rotation += direction.angle()

func destroy():
	queue_free()

func _on_PistolBullet_area_entered(area):
	destroy()

func _on_PistolBullet_body_entered(body):
	destroy()
