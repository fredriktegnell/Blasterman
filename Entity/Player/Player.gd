extends "res://Entity/EntityBase.gd"
class_name Player

export(PackedScene) var TEST_WEAPON: PackedScene = preload("res://Projectiles/PlayerTestWeapon.tscn")
onready var hurtbox = $Hurtbox

func _ready():
	pass
	
func _physics_process(_delta):
	var input_vector = get_input_direction()
	if input_vector != Vector2.ZERO:
		velocity = input_vector * max_speed
	else:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("action_attack"):
		var test_weapon_direction = self.global_position.direction_to(get_global_mouse_position())
		throw_weapon(test_weapon_direction)
		
	move()

func throw_weapon(test_weapon_direction: Vector2):
	if TEST_WEAPON:
		var test_weapon = TEST_WEAPON.instance() # init test_weapon
		get_tree().current_scene.add_child(test_weapon) # add the instance to the scene
		test_weapon.global_position = self.global_position 
		
		var test_weapon_rotation = test_weapon_direction.angle()
		test_weapon.rotation = test_weapon_rotation
		
func get_input_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector


