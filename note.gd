extends Node2D

var target: Node2D
var offset = Vector2.ZERO
var offset_scale = 5

@export var fall_speed := 100
@export var lifetime := 1.5
@onready var sprite: Sprite2D = $Sprite2D

var time_alive := 0.0

func _ready():
	target = get_parent().get_node("Player")
	
func _process(delta):
	if target:
		global_position = global_position.lerp(target.global_position + offset, offset_scale * delta)
	
	position.y += fall_speed * delta
	time_alive += delta
	var fade = 1.0 - (time_alive/lifetime)
	sprite.modulate.a = clamp(fade, 0.0, 1.0)
	
	if time_alive >= lifetime:
		queue_free()
