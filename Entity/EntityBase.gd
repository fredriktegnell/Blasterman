extends KinematicBody2D
class_name EntityBase

export(int) var MAX_HP = 100
export(int) var current_hp = 100

export(int) var MAX_SPEED = 50
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D

func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)

func die():
	queue_free()

func receive_damage(base_damage: int):
	current_hp -= base_damage
	print(name + " recieved " + str(base_damage) + " damage")
	
func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
