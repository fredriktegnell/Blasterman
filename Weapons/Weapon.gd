extends Node2D

class_name Weapon

signal weapon_fired(bullet_instance, location, direction)
signal weapon_out_of_ammo

export (int) var max_ammo: int = 10 
export (bool) var auto: bool = false
export (bool) var shotgun: bool = false

export(PackedScene) var Bullet: PackedScene = preload("res://Projectiles/Bullet.tscn")

var current_ammo: int = max_ammo

onready var endOfGun = $EndOfGun
onready var animation_player = $AnimationPlayer
onready var attack_cooldown = $AttackCooldown
onready var sound_ammo = $SoundAmmo
onready var sound_shooting = $SoundShooting

func _ready() -> void:
	current_ammo = max_ammo
	get_node("/root/World/HUD").update_ammo(current_ammo)

func start_reload():
	animation_player.play("reload") # animation player calls on _stop_reload() when it's finished 

func _stop_reload():
	current_ammo  = max_ammo
	get_node("/root/World/HUD").update_ammo(current_ammo)
	emit_signal("weapon_ammo_changed", current_ammo)

func set_current_ammo(new_ammo: int):
	var actual_ammo = clamp(new_ammo, 0, max_ammo)
	if actual_ammo != current_ammo:
		current_ammo = actual_ammo
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")

		emit_signal("weapon_ammo_changed", current_ammo)
		
func shoot():
	if current_ammo != 0 and attack_cooldown.is_stopped() and Bullet != null:
		if shotgun:
			for angle in [-45, -33.75, -22.5, -11.25, 0, 11.25, 22.5, 33.75, 45]: # angles for all of the shotgun bullets
				var radians = deg2rad(angle)
				var bullet_instance = Bullet.instance() # init bullet_instance
				get_tree().current_scene.add_child(bullet_instance) # add the instance to the scene
				bullet_instance.global_position = endOfGun.global_position
				var direction_to_mouse = (endOfGun.global_position - global_position).normalized()
				bullet_instance.set_direction(direction_to_mouse.rotated(radians))
				emit_signal("weapon_fired", bullet_instance, get_parent().global_position)
		else:
			var bullet_instance = Bullet.instance() # init bullet_instance
			get_tree().current_scene.add_child(bullet_instance) # add the instance to the scene
			bullet_instance.global_position = endOfGun.global_position
			var direction_to_mouse = (endOfGun.global_position - global_position).normalized()
			bullet_instance.set_direction(direction_to_mouse)
			emit_signal("weapon_fired", bullet_instance, get_parent().global_position)
		sound_shooting.play()
		attack_cooldown.start()
		
		current_ammo -= 1
		get_node("/root/World/HUD").update_ammo(current_ammo)
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")
		elif max_ammo / current_ammo > 3:
			get_node("/root/World/HUD").show_message("Low ammunition!")
			sound_ammo.play()
			
func get_class():
	if self.auto:
		return "SMG"
	elif self.shotgun:
		return "Shotgun"
	else:
		return "Pistol"
