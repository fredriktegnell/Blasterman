extends KinematicBody2D
class_name Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ai = $AI
onready var line2d = $Line2D
onready var los = $LineOfSight

const MAX_SPEED = 50
const MAX_HP = 100
var current_hp = 100
var path: Array = [] # Destination positions
var velocity = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func receive_damage(base_damage: int):
	current_hp -= base_damage
	print("current hp: " + str(current_hp))
	
func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
