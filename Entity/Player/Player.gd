extends "res://Entity/EntityBase.gd"
class_name Player

export(PackedScene) var TEST_WEAPON: PackedScene = preload("res://Projectiles/PlayerTestWeapon.tscn")
export(PackedScene) var PISTOL_BULLET: PackedScene = preload("res://Projectiles/PistolBullet.tscn")
onready var hurtbox = $Hurtbox

func _ready():
	pass
	
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
		shoot()
		
func shoot():
	if PISTOL_BULLET:
		var pistol_bullet = PISTOL_BULLET.instance() # init pistol_bullet
		get_tree().current_scene.add_child(pistol_bullet) # add the instance to the scene
		pistol_bullet.global_position = self.global_position
		var target = get_global_mouse_position()
		var direction_to_mouse = self.global_position.direction_to(target).normalized()
		pistol_bullet.set_direction(direction_to_mouse)
		
func throw_weapon():
	if TEST_WEAPON:
		var test_weapon = TEST_WEAPON.instance() # init test_weapon
		get_tree().current_scene.add_child(test_weapon) # add the instance to the scene
		test_weapon.global_position = self.global_position 
		var target = get_global_mouse_position()
		var direction_to_mouse = test_weapon.global_position.direction_to(target).normalized()
		test_weapon.set_direction(direction_to_mouse)
		
func get_input_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector


