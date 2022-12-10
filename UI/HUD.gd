extends CanvasLayer
onready var globalvars = get_node("/root/Global")

onready var weapon_manager = get_node("root/World/YSort/Player/WeaponManager")

func _ready():
	$MessageLabel.hide()

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)
	
func update_ammo(ammo):
	$AmmoLabel.text = "Ammo: " + str(ammo)
	
func update_weapon(weapon):
	$WeaponLabel.text = weapon

func _on_Enemy_died():
	update_score(globalvars.score)

