class_name SpaceUtils


static func set_start_timer(
	timer: Timer, target: float, variance: float
) -> void:
	timer.start(target + randf_range(-variance, variance))
