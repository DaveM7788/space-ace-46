@tool
class_name HitBox extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var collision_shape: Shape2D:
	set(value):
		collision_shape = value
		if is_node_ready():
			apply_shape()


func _ready() -> void:
	apply_shape()


func apply_shape() -> void:
	collision_shape_2d.shape = collision_shape
