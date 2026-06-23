class_name BaseProjectile extends Poolable

@onready var life_timer: Timer = $LifeTimer
@onready var hit_box: HitBox = $HitBox
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
	hit_box.reset()


func _on_screen_notifier_screen_exited() -> void:
	if visible:
		deactivate()


func _on_life_timer_timeout() -> void:
	deactivate()


func _on_hit_box_died(collided_with: Area2D) -> void:
	deactivate()
