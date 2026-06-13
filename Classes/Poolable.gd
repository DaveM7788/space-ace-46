class_name Poolable extends Node2D


var is_available: bool:
	get: return !visible


func _enter_tree() -> void:
	deactivate()


func activate() -> void:
	# deferred is used for physics and collisions
	call_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
	show()


func deactivate() -> void:
	call_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	hide()
