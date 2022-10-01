extends "res://Entity/EntityBase.gd"
class_name Player


onready var hurtbox = $Hurtbox
onready var weapon = $Weapon
# get_tree().current_scene

func _ready():
	weapon.connect("weapon_fired", self, "shoot")
	
func _physics_process(_delta):
	var input_vector = get_input_direction()
	if input_vector != Vector2.ZERO:
		velocity = input_vector * max_speed
	else:
		velocity = Vector2.ZERO
	move()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_attack"):
		#var test_weapon_direction = self.global_position.direction_to(get_global_mouse_position())
		#throw_weapon(test_weapon_direction)
		#var shooting_direction = self.global_position.direction_to(get_global_mouse_position())
		weapon.shoot()
		
func shoot(bullet_instance, location: Vector2, direction: Vector2):
	emit_signal("player_fired_bullet", bullet_instance, location, direction)
			
func get_input_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector


