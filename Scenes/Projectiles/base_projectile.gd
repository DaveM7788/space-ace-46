class_name BaseProjectile extends Poolable

@onready var life_timer: Timer = $LifeTimer
var _mover: Mover


func _ready() -> void:
	for c in get_children():
		if c is Mover:
			_mover = c
			break
	assert(_mover, "BaseProjectile could not find mover")


func activate() -> void:
	super()
	_mover.setup_velocity()
	life_timer.start()


func _on_screen_notifier_screen_exited() -> void:
	if visible:
		deactivate()


func _on_life_timer_timeout() -> void:
	deactivate()
