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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Chest_area_entered(area):
	_nearby_chests.append(self.name)
	print("nearby chests: ")
	print(_nearby_chests)

func _on_Chest_area_exited(area):
	print("left chest")
	print(_nearby_chests)
	_nearby_chests.erase(self.name)


func _physics_process(_delta: float)->void:
	if _nearby_chests.has(self.name) and Input.is_action_just_pressed("ui_select"):
		if self.name in _chest_list:
			return
		else:
			_chest_animation.play("Open")
			_chest_list.append(self.name)
			#print(_chest_list)
			get_loot()

func get_loot():
	print(self.name)
	if self.name == "Chest":
		print("found smg")
		sound_chest.play()
		weapon_manager.add_weapon(smg)
	elif self.name == "Chest2":
		print("found key")
		chest_door.found_key()
		sound_chest.play()
	elif self.name == "Chest3":
		print("found shotgun")
		sound_chest.play()
		weapon_manager.add_weapon(shotgun)
	elif self.name == "Chest4":
		print("found heal")	
		sound_chest.play()
		player.receive_heal(50)
	elif self.name == "Chest5":
		print("found heal")
		sound_chest.play()
		player.receive_heal(50)
			
