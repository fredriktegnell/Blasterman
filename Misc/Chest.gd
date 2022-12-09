extends StaticBody2D

class_name Chest

onready var _chest_animation = $AnimationPlayer
onready var _chest_area = $Chest/CollisionPolygon2D
onready var _chest_list = []

onready var shotgun = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager/Shotgun")
onready var smg = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager/SubMachineGun")
onready var weapon_manager = get_parent().get_parent().get_parent().get_node("YSort/Player/WeaponManager")
onready var player = get_parent().get_parent().get_parent().get_node("YSort/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var inside = false

func _on_Chest_area_entered(area: Area2D)->bool:
	print(area)
	inside = true
	return inside

func _on_Chest_area_exited(area: Area2D)->bool:
	inside = false
	return inside


func _physics_process(_delta: float)->void:
	if inside == true and Input.is_action_just_pressed("ui_select"):
		if self.name in _chest_list:
			return
		else:
			_chest_animation.play("Open")
			_chest_list.append(self.name)
			print(_chest_list)
			get_loot()

func get_loot():
	if self.name == "Chest":
		print("found smg")
		weapon_manager.add_weapon(smg)
	elif self.name == "Chest2":
		print("found key")
	elif self.name == "Chest3":
		print("found shotgun")
		weapon_manager.add_weapon(shotgun)
	elif self.name == "Chest4":
		print("found heal")	
		player.receive_heal(50)
	elif self.name == "Chest5":
		print("found heal")
		player.receive_heal(50)
			






