extends CanvasLayer

func _ready():
	set_visible(false)

func _input(event):
	if event.get_action_strength("ui_cancel"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused

func _on_ContinueButton_pressed():
	get_tree().paused = false
	set_visible(false)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_QuitButton_pressed():
	get_tree().quit()

