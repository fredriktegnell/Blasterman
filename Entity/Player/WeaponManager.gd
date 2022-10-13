extends Node2D

onready var current_weapon = $Pistol

var weapons: Array = []

func _ready() -> void:
	weapons = get_children()
	current_weapon.connect("weapon_fired", self, "shoot")
	current_weapon.connect("weapon_out_of_ammo", self, "reload")
	
func reload():
	current_weapon.start_reload()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_attack"):
		#var test_weapon_direction = self.global_position.direction_to(get_global_mouse_position())
		#throw_weapon(test_weapon_direction)
		#var shooting_direction = self.global_position.direction_to(get_global_mouse_position())
		current_weapon.shoot()
	elif event.is_action_pressed("action_reload"):
		current_weapon.start_reload()
