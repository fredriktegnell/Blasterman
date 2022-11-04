extends Node2D

signal weapon_changed(new_weapon)

onready var current_weapon: Weapon = $Pistol

var weapons: Array = []

func _ready() -> void:
	weapons = get_children()
	for weapon in weapons:
		weapon.hide()
	current_weapon.show()
	current_weapon.connect("weapon_fired", self, "shoot")
	current_weapon.connect("weapon_out_of_ammo", self, "reload")
	
func get_current_weapon() -> Weapon:
	return current_weapon
	
func reload():
	current_weapon.start_reload()
	
func switch_weapon(weapon: Weapon):
	if weapon == current_weapon:
		return
	current_weapon.hide()
	weapon.show()
	current_weapon = weapon
	emit_signal("weapon_changed", current_weapon)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_attack"):
		#var test_weapon_direction = self.global_position.direction_to(get_global_mouse_position())
		#throw_weapon(test_weapon_direction)
		#var shooting_direction = self.global_position.direction_to(get_global_mouse_position())
		current_weapon.shoot()
	elif event.is_action_pressed("action_reload"):
		current_weapon.start_reload()
	elif event.is_action_pressed("weapon_1"):
		switch_weapon(weapons[0])
	elif event.is_action_pressed("weapon_2") and weapons[1]:
		switch_weapon(weapons[1])
