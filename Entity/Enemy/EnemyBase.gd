extends "res://Entity/EntityBase.gd"
class_name EnemyBase

onready var ai = $AI
onready var line2d = $Line2D
onready var los = $LineOfSight

var path: Array = [] # Destination positions

func _ready():
	ai.initialize(self)
