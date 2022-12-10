extends "res://Entity/EntityBase.gd"
class_name EnemyBase

onready var ai = $AI
onready var line2d = $Line2D
onready var los = $LineOfSight
onready var block_detector = $BlockDetector

var path: Array = [] # Destination positions
	
func _ready():
	set_max_speed(30)
	ai.initialize(self)

func get_class(): return "EnemyBase"
