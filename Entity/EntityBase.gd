extends KinematicBody2D
class_name EntityBase
signal max_hp_changed(new_max_hp)
signal current_hp_changed(new_current_hp)
signal died()

export(int) var max_hp: int = 100 setget set_max_hp 
export(int) var current_hp: int = max_hp setget set_current_hp

export(int) var max_speed = 50 setget set_max_speed
var velocity = Vector2.ZERO
onready var HUD = get_node("/root/UI/HUD")
onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var healthBar = $EntityHealthBar
onready var sound_hp = $SoundHP
onready var globalvars = get_node("/root/Global")


func set_max_speed(new_speed):
	max_speed = new_speed

func set_current_hp(value):
	if value != current_hp:
		current_hp = clamp(value, 0, max_hp)
		emit_signal("hp_changed", current_hp)
		healthBar.animate_hp_change(current_hp)
		if current_hp == 0:
			emit_signal("died")
			
		elif current_hp != max_hp:
			healthBar.show()
			
		
	
func set_max_hp(value):
	if value != max_hp:
		max_hp = max(0, value)
		emit_signal("max_hp_changed", max_hp)
		healthBar.max_value = max_hp
		self.current_hp = current_hp
		

func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)

func die():
	if get_class() == "Player":
		get_tree().change_scene("res://UI/TitleScreen/DeathScreen.tscn")
	elif get_class() != "Player":
		globalvars.score += 100
		get_node("/root/World/HUD").update_score(globalvars.score)
		queue_free()

func receive_damage(base_damage: int):
	self.current_hp -= base_damage
	if get_class() == "Player" and self.current_hp <= 30:
		sound_hp.play()

func receive_heal(heal_amount: int):
	self.current_hp += heal_amount
	
func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	if hitbox.is_in_group("projectile"):
		hitbox.destroy()

func _on_EntityBase_died():
	die()
