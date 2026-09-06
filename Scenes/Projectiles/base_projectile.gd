class_name BaseProjectile extends Poolable

@export var explosion_scene: PackedScene
@export var explosion_margin: float = 40.0
@export var points := 0
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


func explode(collider_position: Vector2) -> void:
	if !explosion_scene: 
		return
	var direction = global_position.direction_to(collider_position)
	var explode_position = global_position + direction * explosion_margin
	SignalHub.emit_spawn_pool_object(explode_position, explosion_scene)


func _on_screen_notifier_screen_exited() -> void:
	if visible:
		deactivate()


func _on_life_timer_timeout() -> void:
	deactivate()


func _on_hit_box_died(collided_with: Area2D) -> void:
	SignalHub.emit_points_scored(points)
	explode(collided_with.global_position)
	deactivate()
