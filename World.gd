extends Node2D

const EnemyBase = preload("res://Entity/Enemy/EnemyBase.tscn")
onready var basic_spawn_timer = $BasicSpawnTimer

#var rng = RandomNumberGenerator.new()
const max_x = 350
const max_y = -200
const min_x = 250
const min_y = -250
var spawn_amount = 1
var wave_counter = 0

func _ready():
	randomize()
	
func _on_BasicSpawnTimer_timeout():
	print(spawn_amount)
	print(wave_counter)
	for n in spawn_amount:
		var Enemy = EnemyBase.instance()
		Enemy.scale = Vector2(0.5, 0.5)
		var random_x_position = rand_range(min_x, max_x)
		var random_y_position = rand_range(min_y, max_y)
		Enemy.global_position = Vector2(random_x_position, random_y_position)
		add_child(Enemy)
	wave_counter = wave_counter + 1
	if wave_counter == 1:
		spawn_amount = spawn_amount + 1
		wave_counter = 0
