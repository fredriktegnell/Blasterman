extends StaticBody2D

class_name Chest

onready var _chest_animation = $AnimationPlayer
onready var _chest_area = $Chest/CollisionPolygon2D
onready var _chest_list = []
onready var _nearby_chests = []

onready var shotgun = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager/Shotgun")
onready var smg = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager/SubMachineGun")
onready var weapon_manager = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager")
onready var player = get_parent().get_parent().get_parent().get_node("YSort/Player")
onready var sound_chest = get_parent().get_parent().get_parent().get_node("SoundChest")
onready var chest_door = get_parent().get_node("CellDoor")

func _on_Chest_area_entered(area):
	_nearby_chests.append(self.name)

func _on_Chest_area_exited(area):
	_nearby_chests.erase(self.name)

func _physics_process(_delta: float)->void:
	if _nearby_chests.has(self.name) and Input.is_action_just_pressed("ui_select"):
		if self.name in _chest_list:
			return
		else:
			_chest_animation.play("Open")
			_chest_list.append(self.name)
			get_loot()

func get_loot():
	if self.name == "Chest":
		get_node("/root/World/HUD").show_message("You found a SMG!")
		sound_chest.play()
		weapon_manager.add_weapon(smg)
	elif self.name == "Chest2":
		get_node("/root/World/HUD").show_message("You found a key!")
		chest_door.found_key()
		sound_chest.play()
	elif self.name == "Chest3":
		get_node("/root/World/HUD").show_message("You found a shotgun!")
		sound_chest.play()
		weapon_manager.add_weapon(shotgun)
	elif self.name == "Chest4":
		get_node("/root/World/HUD").show_message("You got healed!")
		sound_chest.play()
		player.receive_heal(100)
	elif self.name == "Chest5":
		get_node("/root/World/HUD").show_message("Your found larger ammunition magazines!")
		weapon_manager.weapons[0].max_ammo += 30
		weapon_manager.weapons[1].max_ammo += 5
		weapon_manager.weapons[2].max_ammo += 10
		weapon_manager.weapons[0].current_ammo += 30
		weapon_manager.weapons[1].current_ammo += 5
		weapon_manager.weapons[2].current_ammo += 10
		get_node("/root/World/HUD").update_ammo(weapon_manager.current_weapon.current_ammo)
		sound_chest.play()
			
