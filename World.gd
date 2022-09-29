extends Node2D

const EnemyBase = preload("res://Entity/Enemy/EnemyBase.tscn")

#var rng = RandomNumberGenerator.new()
const max_x = 350
const max_y = 420
const min_x = -370
const min_y = -240


func _ready():

	randomize()
	for i in 10:
		var Enemy = EnemyBase.instance()
		Enemy.scale = Vector2(0.5, 0.5)
		var random_x_position = rand_range(min_x, max_x)
		var random_y_position = rand_range(min_y, max_y)
		Enemy.global_position = Vector2(random_x_position, random_y_position)
		#add_child(Enemy)
	
