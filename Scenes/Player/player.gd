class_name Player extends Node2D


func _on_hit_box_hit(damage: int) -> void:
	SignalHub.emit_player_take_damage(damage)
