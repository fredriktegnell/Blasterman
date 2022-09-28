extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}

onready var patrol_timer = $PatrolTimer

var current_state: int = -1 setget set_state
var actor: KinematicBody2D = null
var player: Player = null
var levelNavigation: Navigation2D = null
#var player_spotted: bool = false
# Patrol State
var origin: Vector2 = Vector2.ZERO
var prev_patrol_location: Vector2 =  Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO

func _ready():
	yield(get_tree(), "idle_frame") # wait for get_tree() to be rdy
	var tree = get_tree()
	if tree.has_group("levelnavigation"):
		levelNavigation = tree.get_nodes_in_group("levelnavigation")[0]
		print(levelNavigation)
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]
		print(player)
	set_state(State.PATROL)

func _physics_process(_delta: float) -> void:
	actor.line2d.global_position = Vector2.ZERO
	if player != null: # making sure player is initiated
		actor.los.look_at(player.global_position)
	check_player_in_detection()
	match current_state:
		State.PATROL:
			actor.block_detector.look_at(patrol_location) # temporary collision handling 
			if not patrol_location_reached:
				var block_collider = actor.block_detector.get_collider()
				if actor.global_position.distance_to(patrol_location) < 5 or block_collider:
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
				actor.move_and_slide(actor_velocity)
		State.ENGAGE:
			if player != null and actor != null and levelNavigation != null:
				#actor.rotation = actor.global_position.direction_to(player.global_position).angle() # will work with real top-down sprite
				#actor.velocity = actor.global_position.direction_to(player.global_position) * actor.max_speed
				generate_path()
				navigate()
				actor.velocity = actor.move_and_slide(actor.velocity)
			else:
				print("In the engage state but no player and/or actor")
				pass
		_: # default case
			print("Error: state error")

func check_player_in_detection() -> bool:
	var collider = actor.los.get_collider()
	if collider and collider.is_in_group("player"):
		set_state(State.ENGAGE)
		#player_spotted = true
		return true
	return false

func initialize(actor):
	self.actor = actor

func set_state(new_state: int):
	if new_state == current_state:
		return
	if new_state == State.PATROL:
		origin = actor.global_position
		prev_patrol_location = origin
		patrol_timer.start()
		patrol_location_reached = true
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func navigate(): # next position to go to
	if actor.path.size() > 0:
		actor.velocity = actor.global_position.direction_to(actor.path[1]) * actor.max_speed
		
		# If destination reached, remove the point from path array
		if actor.global_position == actor.path[0]:
			actor.path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		actor.path = levelNavigation.get_simple_path(actor.global_position, player.global_position, false)
		actor.line2d.points = actor.path
		

		


func _on_PatrolTimer_timeout():

	var patrol_range = 100
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + prev_patrol_location
	prev_patrol_location = patrol_location
	patrol_location_reached = false
	actor_velocity = actor.global_position.direction_to(patrol_location) * actor.max_speed
	
