extends KinematicBody2D
class_name Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ai = $AI
onready var line2d = $Line2D

var path: Array = [] # Destination positions
var velocity = Vector2.ZERO
const MAX_SPEED = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	ai.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
