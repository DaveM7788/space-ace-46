class_name AsteroidExplosion extends Poolable

@onready var pieces: Node2D = $Pieces
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer = $Sound

var _pieces: Array[AsteroidPiece] = []

func _ready() -> void:
	for item in pieces.get_children():
		if item is AsteroidPiece:
			_pieces.append(item)
			item.reset()


func deactivate() -> void:
	for p in _pieces:
		p.reset()
	super()


func activate() -> void:
	super()
	timer.start()
	sound.play()


func _on_timer_timeout() -> void:
	deactivate()
