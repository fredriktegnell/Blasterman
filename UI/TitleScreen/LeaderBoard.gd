extends Control


onready var globalvars = get_node("/root/Global")
onready var scores = $Menu/Scores
var result = ""
func _ready():
	update_leaderboard()
	pass
	
func update_leaderboard():
	globalvars.leaderboard.sort()
	for i in range(len(globalvars.leaderboard)-1, -1, -1):
		result = result + str(globalvars.leaderboard[i]) + "\n"
	scores.text = result
	

func _physics_process(delta):
	if Input.get_action_strength("ui_cancel") and globalvars.leaderboard == []:
		get_tree().change_scene("res://UI/TitleScreen/TitleScreen.tscn")
	elif Input.get_action_strength("ui_cancel") and globalvars.leaderboard != []:
		get_tree().change_scene("res://UI/TitleScreen/DeathScreen.tscn")

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

