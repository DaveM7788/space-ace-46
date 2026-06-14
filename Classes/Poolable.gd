class_name Poolable extends Node2D


var is_available: bool:
	get: return !visible


func _enter_tree() -> void:
	deactivate()


func activate() -> void:
	# deferred is used for physics and collisions
	# changed this from process_mode to set_process_mode
	call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)
	show()


func deactivate() -> void:
	call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	hide()
