extends Area2D

onready var _animated_sprite = $AnimatedSprite
onready var _bridge = get_node("../../LevelNavigation/Bridge")
onready var _bridge_nodes = get_node("../../LevelNavigation/Bridge").get_used_cells()
onready var _bridge2 = get_node("../../LevelNavigation/Bridge2")
onready var _bridge_nodes2 = get_node("../../LevelNavigation/Bridge2").get_used_cells()
onready var _water_collision = get_node("../../LevelNavigator/WaterCollision")
onready var _ground_path = "../../LevelNavigator/BaseBackground"

var inside = false

export(int) var damage: int = 0



func _on_Lever_area_entered(area: Area2D)->bool:
	inside = true
	return inside


func _on_Lever_area_exited(area:Area2D)->bool:
	inside = false
	return inside


func _physics_process(_delta: float)->void:
	
	if inside == true:
		if Input.is_action_just_pressed("ui_select"):
			if _animated_sprite.frame == 0:
				for pos in _bridge_nodes:
					get_node("../../LevelNavigation/WaterCollision").set_cell(pos[0],pos[1],5)
				for pos in _bridge_nodes2:
					get_node("../../LevelNavigation/WaterCollision").set_cell(pos[0],pos[1],-1)
				get_node("../../LevelNavigation").remove_child(_bridge)
				get_node("../../LevelNavigation").add_child(_bridge2)
				_animated_sprite.frame = 1
			elif _animated_sprite.frame == 1:
				for pos in _bridge_nodes:
					get_node("../../LevelNavigation/WaterCollision").set_cell(pos[0],pos[1],-1)
				for pos in _bridge_nodes2:
					get_node("../../LevelNavigation/WaterCollision").set_cell(pos[0],pos[1],5)
				get_node("../../LevelNavigation").add_child(_bridge)
				get_node("../../LevelNavigation").remove_child(_bridge2)
				_animated_sprite.frame = 0
				
				
				
			
	
	
