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

func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and actor != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				print(actor.rotation)
			else:
				print("In the engage state but no player")
		_: # default case
			print("Error: state error")

func initialize(actor):
	self.actor = actor


func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)




func _on_PlayerDetectionZone_body_entered(body: Node) -> void:
	print("player detected")
	if body.is_in_group("player"):
		print("setting state to engage")
		set_state(State.ENGAGE)
		player = body
		
