class_name GameUI extends Control

@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var music: AudioStreamPlayer = $Music
@onready var boost_sound: AudioStreamPlayer = $BoostSound
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound
@onready var color_rect: ColorRect = $ColorRect

var _score := 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()


func _ready() -> void:
	get_tree().paused = false
	SignalHub.player_take_damage.connect(on_player_take_damage)
	SignalHub.player_health_boost.connect(on_player_health_boost)
	SignalHub.points_scored.connect(on_points_scored)


func on_player_take_damage(damage: int) -> void:
	health_bar.take_damage(damage)


func on_player_health_boost(boost: int) -> void:
	health_bar.incr_value(boost)
	boost_sound.play()


func on_points_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score


func _on_health_bar_died() -> void:
	music.stop()
	game_over_sound.play()
	color_rect.show()
	get_tree().paused = true
	
