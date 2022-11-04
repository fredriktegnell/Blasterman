extends StaticBody2D

onready var _door = $Area2D/DoorAnimation



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var inside = false
var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area: Area2D)->bool:
	inside = true
	return inside
	


func _on_Area2D_area_exited(area: Area2D)->bool:
	inside = false
	return inside
	
func _physics_process(_delta: float)->void:
	if inside == true:
		if Input.is_action_just_pressed("ui_select") and open != true:
			_door.play("Open")
			open = true
			get_node("CollisionShape2D").disabled = true 
		elif Input.is_action_just_pressed("ui_select") and open == true:
			_door.play("Close")
			open = false
			get_node("CollisionShape2D").disabled = false
			
		
		
			
			
			
			
