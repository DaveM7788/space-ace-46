class_name Asteroid extends BaseProjectile

@export var textures: Array[Texture2D] = []
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	super()
	sprite_2d.texture = textures.pick_random()
