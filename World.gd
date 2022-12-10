extends Node2D

const EnemyBase = preload("res://Entity/Enemy/EnemyBase.tscn")
onready var basic_spawn_timer = $BasicSpawnTimer
onready var leaderboard = get_node("LeaderBoard")


#var rng = RandomNumberGenerator.new()
# coordinates of areas corners [min_x, max_x, min_y, max_y]
const spawn_area_NW = [-170, -110, -220, -140] # spawn area located north west
const spawn_area_NE = [250, 350, -250, -200] # spawn area located north east
const spawn_area_SE = [330, 370, 320, 390] # spawn area located south east
const spawn_area_SW = [-350, -150, 320, 370] # spawn area located south west
const spawn_areas = [spawn_area_NW, spawn_area_NE, spawn_area_SE, spawn_area_SW]

var spawn_amount = 1 # amount of enemies spawned in current wave
var wave_counter = 0 # number of waves since increasing the amount of enemies spawned


func _ready():
	remove_child(leaderboard)
	randomize()
	

	
func _on_BasicSpawnTimer_timeout():
	var temp_spawn_area = spawn_areas[randi() % spawn_areas.size()] 
	for n in spawn_amount:
		var Enemy = EnemyBase.instance()
		Enemy.scale = Vector2(0.5, 0.5)
		var random_x_position = rand_range(temp_spawn_area[0], temp_spawn_area[1])
		var random_y_position = rand_range(temp_spawn_area[2], temp_spawn_area[3])
		Enemy.global_position = Vector2(random_x_position, random_y_position)
		add_child(Enemy)
		
	wave_counter = wave_counter + 1
	if wave_counter == 1:
		spawn_amount = spawn_amount + 1
		wave_counter = 0


