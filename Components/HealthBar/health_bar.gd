class_name HealthBar extends TextureProgressBar

signal died
const COLOR_DANGER := Color("#cc0000")
const COLOR_MIDDLE := Color("#ff9900")
const COLOR_GOOD := Color("#33cc33")
@export var level_low := 30
@export var level_med := 65
@export var start_health := 100
@export var max_health := 100
var _dead := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_health = max_health
	value = start_health


func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD


func incr_value(v: int) -> void:
	value += v
	if value <= 0 && !_dead:
		_dead = true
		died.emit()
	set_color()


func take_damage(damage: int) -> void:
	incr_value(-damage)
