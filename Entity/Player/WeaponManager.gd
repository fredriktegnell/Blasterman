extends Node2D

class_name WeaponManager

signal weapon_changed(new_weapon)

onready var current_weapon: Weapon = $Pistol
onready var HUD = get_parent().get_parent().get_parent().get_node("HUD")

var weapons: Array = []

onready var available_weapons: Array = [current_weapon]

func _ready() -> void:
	print(available_weapons)
	weapons = get_children()
	for weapon in weapons:
		weapon.hide()
	current_weapon.show()
	current_weapon.connect("weapon_fired", self, "shoot")
	current_weapon.connect("weapon_out_of_ammo", self, "reload")
	HUD.update_weapon(current_weapon.get_class())
	
func _process(delta: float) -> void:
	if current_weapon.auto and Input.is_action_pressed("action_attack"):
		current_weapon.shoot()
		
func get_current_weapon() -> Weapon:
	return current_weapon
	
func reload():
	current_weapon.start_reload()
	
func add_weapon(found_weapon: Weapon):
	if not available_weapons.has(found_weapon):
		available_weapons.append(found_weapon)
	
func switch_weapon(weapon: Weapon):
	if weapon == current_weapon or not available_weapons.has(weapon):
		return
	else:
		current_weapon.hide()
		weapon.show()
		current_weapon = weapon
		HUD.update_weapon(current_weapon.get_class())
		current_weapon.connect("weapon_fired", self, "shoot")
		current_weapon.connect("weapon_fired", self, "shoot")
		current_weapon.connect("weapon_out_of_ammo", self, "reload")
		emit_signal("weapon_changed", current_weapon)
		

func _unhandled_input(event: InputEvent) -> void:
	if not current_weapon.auto and event.is_action_pressed("action_attack"):
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
	elif event.is_action_pressed("weapon_3") and weapons[2]:
		switch_weapon(weapons[2])
