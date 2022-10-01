extends Node2D

signal weapon_fired(bullet_instance, location, direction)

#export(PackedScene) var Test_Weapon: PackedScene = preload("res://Projectiles/PlayerTestWeapon.tscn")
export(PackedScene) var Bullet: PackedScene = preload("res://Projectiles/Bullet.tscn")

func shoot():
	if Bullet:
		var bullet_instance = Bullet.instance() # init bullet_instance
		get_tree().current_scene.add_child(bullet_instance) # add the instance to the scene
		bullet_instance.global_position = get_parent().global_position
		var target = get_global_mouse_position()
		var direction_to_mouse = get_parent().global_position.direction_to(target).normalized()
		bullet_instance.set_direction(direction_to_mouse)
		emit_signal("weapon_fired", bullet_instance, get_parent().global_position)


#func throw_weapon():
#	if Test_Weapon:
#		var test_weapon = Test_Weapon.instance() # init test_weapon
#		get_tree().current_scene.add_child(test_weapon) # add the instance to the scene
#		test_weapon.global_position = self.global_position 
#		var target = get_global_mouse_position()
#		var direction_to_mouse = test_weapon.global_position.direction_to(target).normalized()
#		test_weapon.set_direction(direction_to_mouse)
#		emit_signal("weapon_fired", test_weapon, self.global_position)
