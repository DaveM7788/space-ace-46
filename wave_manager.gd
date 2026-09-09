class_name WaveManager extends Node

@export var is_enabled = true
@export var waves_list: Array[Wave] = []
@export var paths_list: Array[Path2D] = []
@onready var wave_timer: Timer = $WaveTimer
@onready var ship_timer: Timer = $ShipTimer

var _current_wave_idx := -1
var _current_wave: Wave
var _current_path: Path2D
var _enemies_spawned := 0


func _ready() -> void:
	if !is_enabled: return
	start_next_wave()


func start_next_wave() -> void:
	_current_wave_idx = (_current_wave_idx + 1) % waves_list.size()
	_current_wave = waves_list[_current_wave_idx]
	_current_path = paths_list.pick_random()
	_enemies_spawned = 0
	ship_timer.start(_current_wave.spawn_internal)


func _on_wave_timer_timeout() -> void:
	start_next_wave()


func _on_ship_timer_timeout() -> void:
	var enemy := _current_wave.enemy_scene.instantiate()
	_current_path.add_child(enemy)
	_enemies_spawned += 1
	if _enemies_spawned >= _current_wave.enemy_count:
		wave_timer.start(_current_wave.wave_interval)
	else:
		ship_timer.start(_current_wave.spawn_internal)
