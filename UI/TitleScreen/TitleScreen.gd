extends Control

onready var globalvars = get_node("/root/Global")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGame_pressed():
	
	get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.


func _on_LeaderBoard_pressed():
	get_tree().change_scene("res://UI/TitleScreen/LeaderBoard.tscn")
	pass # Replace with function body.
