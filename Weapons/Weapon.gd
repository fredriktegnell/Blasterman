extends Node2D

class_name Weapon

signal weapon_fired(bullet_instance, location, direction)
signal weapon_out_of_ammo

export (int) var max_ammo: int = 10 
export (bool) var auto: bool = false

#export(PackedScene) var Test_Weapon: PackedScene = preload("res://Projectiles/PlayerTestWeapon.tscn")
export(PackedScene) var Bullet: PackedScene = preload("res://Projectiles/Bullet.tscn")

var current_ammo: int = max_ammo

onready var endOfGun = $EndOfGun

func _ready() -> void:
	current_ammo = max_ammo

func start_reload():
	# animation and/or sound for reload here 
	#print("reloading")
	_stop_reload() # the animation player shall be used to call _stop_reload() instead of here 
	# see here how to do it: https://www.youtube.com/watch?v=YAoueKaqhkc&list=PLpwc3ughKbZexDyPexHN2MXLliKAovkpl&index=11

func _stop_reload(): # _ before function name = private function 
	current_ammo  = max_ammo
	emit_signal("weapon_ammo_changed", current_ammo)

func set_current_ammo(new_ammo: int):
	var actual_ammo = clamp(new_ammo, 0, max_ammo)
	if actual_ammo != current_ammo:
		current_ammo = actual_ammo
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")

		emit_signal("weapon_ammo_changed", current_ammo)

func shoot():
	if Bullet and current_ammo != 0:
		var bullet_instance = Bullet.instance() # init bullet_instance
		get_tree().current_scene.add_child(bullet_instance) # add the instance to the scene
		bullet_instance.global_position = endOfGun.global_position
		var direction_to_mouse = (endOfGun.global_position - global_position).normalized()
		bullet_instance.set_direction(direction_to_mouse)
		emit_signal("weapon_fired", bullet_instance, get_parent().global_position)
		current_ammo -= 1
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")


#func throw_weapon():
#	if Test_Weapon:
#		var test_weapon = Test_Weapon.instance() # init test_weapon
#		get_tree().current_scene.add_child(test_weapon) # add the instance to the scene
#		test_weapon.global_position = self.global_position 
#		var target = get_global_mouse_position()
#		var direction_to_mouse = test_weapon.global_position.direction_to(target).normalized()
#		test_weapon.set_direction(direction_to_mouse)
#		emit_signal("weapon_fired", test_weapon, self.global_position)
