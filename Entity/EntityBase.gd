extends KinematicBody2D
class_name EntityBase

signal max_hp_changed(new_max_hp)
signal current_hp_changed(new_current_hp)
signal died()

export(int) var max_hp: int = 100 setget set_max_hp 
export(int) var current_hp: int = max_hp setget set_current_hp

export(int) var MAX_SPEED = 50
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
	
func set_current_hp(value):
	if value != current_hp:
		current_hp = clamp(value, 0, max_hp)
		emit_signal("hp_changed", current_hp)
		if current_hp == 0:
			emit_signal("died")
	
func set_max_hp(value):
	if value != max_hp:
		max_hp = max(0, value)
		emit_signal("max_hp_changed", max_hp)
		self.current_hp = current_hp
		

func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)

func die():
	queue_free()

func receive_damage(base_damage: int):
	self.current_hp -= base_damage
	print(name + " recieved " + str(base_damage) + " damage")
	
func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)

func _on_EntityBase_died():
	die()
