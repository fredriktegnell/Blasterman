extends Node2D

onready var _animation = $AnimationPlayer
export(int) var fire_damage: int = 10

func _ready():
	_animation.play("idle")

func _on_Area2D_body_entered(body):
	get_node("/root/World/HUD").show_message("You got burnt!")
	body.receive_damage(fire_damage)

