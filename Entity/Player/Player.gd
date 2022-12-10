extends "res://Entity/EntityBase.gd"
class_name Player


onready var hurtbox = $Hurtbox
onready var weapon_manager = $WeaponManager
onready var chest = $Chest

func _ready():
	weapon_manager.connect("weapon_fired", self, "shoot")
	weapon_manager.connect("weapon_out_of_ammo", self, "reload")
	weapon_manager.connect("weapon_changed", self, "set_weapon")
	
func _physics_process(_delta):
	var input_vector = get_input_direction()
	if input_vector != Vector2.ZERO:
		velocity = input_vector * max_speed
	else:
		velocity = Vector2.ZERO
	move()
	look_at(get_global_mouse_position())
		
func shoot(bullet_instance, location: Vector2, direction: Vector2):
	emit_signal("player_fired_bullet", bullet_instance, location, direction)
		
func get_input_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector

func get_class(): return "Player"
