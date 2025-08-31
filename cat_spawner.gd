extends Node2D

@export var cat_scene: PackedScene
@export var spawn_area: Rect2
@export var camera_margin := 200.0
var num_cats = 30
var player: Node2D = null
@onready var camera: Camera2D = get_viewport().get_camera_2d()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	spawn_area = Rect2(Vector2(-2000,400), Vector2(2000,398))
	
	for i in range(num_cats):
		spawn_cat(i)
		
func spawn_cat(j: int):
	var cat = cat_scene.instantiate()
	add_child(cat)
	var x = randf_range(-2000, 2000)
	var y = 0
	if x < 550 && x > 350:
		x=1000+x
	var rb = cat.get_node("RigidBody2D")
	rb.global_position = Vector2(x, y)
	rb.cat_name = j
	print_debug(x)
	
func is_in_camera_view(pos: Vector2) -> bool:
	var rect = Rect2(
		camera.global_position - camera.get_viewport_rect().size/2,
		camera.get_viewport_rect().size
	).grow(camera_margin)
	
	return rect.has_point(pos)
