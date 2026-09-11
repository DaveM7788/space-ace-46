extends Node

@export var is_enabled := true
# scene must extend Poolable
@export var scene: PackedScene
@export var wait_time := 5.0
@onready var timer: Timer = $Timer


func _ready() -> void:
	if !is_enabled: return
	timer.start(wait_time)


func _on_timer_timeout() -> void:
	if !scene: return
	SignalHub.emit_spawn_pool_object(Vector2.ZERO, scene)
