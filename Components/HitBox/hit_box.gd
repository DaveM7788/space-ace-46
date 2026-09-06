@tool
class_name HitBox extends Area2D

signal died(collided_with: Area2D)
signal hit(damage: int)

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var max_collisions := 1
var _collisions_left := 1
@export var damage_dealt := 15
@export var collision_shape: Shape2D:
	set(value):
		collision_shape = value
		if is_node_ready():
			apply_shape()

@onready var invincibility_timer: Timer = $InvincibilityTimer
@export var invincible_time := 0.0
var _invincible := false

func _ready() -> void:
	apply_shape()
	reset()


func apply_shape() -> void:
	collision_shape_2d.shape = collision_shape


func reset() -> void:
	_collisions_left = max_collisions
	_invincible = false
	if !is_zero_approx(invincible_time):
		invincibility_timer.start(invincible_time)
		_invincible = true


func _on_area_entered(area: Area2D) -> void:
	if _invincible: return
	
	if area is HitBox:
		hit.emit(area.damage_dealt)

	_collisions_left -= 1
	if _collisions_left <= 0:
		died.emit(area)
		print(get_parent().name + " 0 collisions left hitbox")


func _on_invincibility_timer_timeout() -> void:
	_invincible = false
