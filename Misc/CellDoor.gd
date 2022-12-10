extends StaticBody2D

onready var _door_right = $AnimatedSprite
onready var _door_left = $AnimatedSprite2
onready var cellDoorArea = $CellDoor/CellDoorArea

var key_found = false
var open = false
var inside_door = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func found_key():
	key_found = true

func _on_CellDoor_area_entered(area):
	inside_door = true
	return inside_door

func _on_CellDoor_area_exited(area):
	inside_door = false
	return inside_door
	
func _physics_process(_delta: float)->void:
	if inside_door == true:
		if Input.is_action_just_pressed("ui_select") and open != true and key_found == true:
			_door_left.play("open")
			_door_right.play("open")
			get_node("CollisionPolygon2D").disabled = true
			open == true
			
		elif Input.is_action_just_pressed("ui_select") and open == true:
			return


