extends KinematicBody2D
class_name Player




const MAX_SPEED = 100
const MAX_HP = 100
var current_hp = 100
var velocity = Vector2.ZERO



func _ready():
	pass
	
func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * MAX_SPEED
	else:
		velocity = Vector2.ZERO
			
	velocity = move_and_slide(velocity)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
