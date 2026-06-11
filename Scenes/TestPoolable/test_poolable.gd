class_name TestPoolable extends Node2D

static var count := 1

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(count)
	count += 1
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
