extends StaticBody2D


onready var _chest_animation = $AnimationPlayer
onready var _chest_area = $Chest/CollisionPolygon2D
onready var _chest_list = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
			






