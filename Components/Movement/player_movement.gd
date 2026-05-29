extends Node

@export var speed := 300.0
@export var input_up := "up"
@export var input_down := "down"
@export var input_right := "right"
@export var input_left := "left"
@export var margin := 64.0

var _parent: Node2D
var _movement_rect: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_parent = get_parent() as Node2D
	if !_parent:
		printerr("Player movement script could not get parent")
		queue_free()
	else:
		_movement_rect = _parent.get_viewport_rect().grow(-margin)


func _physics_process(delta: float) -> void:
	var input := Vector2(
		Input.get_axis(input_left, input_right),
		Input.get_axis(input_up, input_down)
	).normalized()
	
	_parent.position += input * speed * delta
	_parent.position = _parent.position.clamp(
		_movement_rect.position,
		_movement_rect.end
	)
