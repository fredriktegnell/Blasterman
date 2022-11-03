extends StaticBody2D

onready var _door_right = $AnimatedSprite
onready var _door_left = $AnimatedSprite2
onready var cellDoorArea = $CellDoor/CellDoorArea


var open = false
var inside = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CellDoor_area_entered(area: Area2D)->bool:

	inside= true
	return inside 


func _on_CellDoor_area_exited(area: Area2D)->bool:
	inside = false
	return inside

	


	
func _physics_process(_delta: float)->void:
	
	if inside == true:
		if Input.is_action_just_pressed("ui_select") and open != true:
			_door_left.play("open")
			_door_right.play("open")
			get_node("CollisionPolygon2D").disabled = true
			open == true
			
		elif Input.is_action_just_pressed("ui_select") and open == true:
			return
	
	
				




