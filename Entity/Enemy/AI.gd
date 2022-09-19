extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}


onready var player_detection_zone = $PlayerDetectionZone


var current_state: int = State.PATROL setget set_state
var actor = null
var player: Player = null
var levelNavigation: Navigation2D = null
var player_spotted: bool = false


func _ready():
	yield(get_tree(), "idle_frame") # wait for get_tree() to be rdy
	var tree = get_tree()
	if tree.has_group("levelnavigation"):
		print("found levelnavigation group")
		levelNavigation = tree.get_nodes_in_group("levelnavigation")[0]
		print(levelNavigation)
	if tree.has_group("player"):
		print("found player group")
		player = tree.get_nodes_in_group("player")[0]
		print(player)

func _process(_delta: float) -> void:
	actor.line2d.global_position = Vector2.ZERO
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and actor != null and levelNavigation != null:
				#actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				#actor.velocity = actor.global_position.direction_to(player.global_position) * actor.MAX_SPEED
				actor.los.look_at(player.global_position)
				check_player_in_detection()
				if player_spotted:
					generate_path()
					navigate()
					actor.velocity = actor.move_and_slide(actor.velocity)
			else:
				print("In the engage state but no player and/or actor")
		_: # default case
			print("Error: state error")

func check_player_in_detection() -> bool:
	var collider = actor.los.get_collider()
	if collider and collider.is_in_group("player"):
		player_spotted = true
		return true
	return false

func initialize(actor):
	self.actor = actor

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func navigate(): # next position to go to
	if actor.path.size() > 0:
		#print("path size is not empty")
		actor.velocity = actor.global_position.direction_to(actor.path[1]) * actor.MAX_SPEED
		
		# If destination reached, remove the point from path array
		if actor.global_position == actor.path[0]:
			actor.path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		#print("levelnavigation and player exists")
		actor.path = levelNavigation.get_simple_path(actor.global_position, player.global_position, false)
		actor.line2d.points = actor.path

func _on_PlayerDetectionZone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
		#print(player)
		