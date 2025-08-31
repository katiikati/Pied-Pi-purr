extends RigidBody2D

var following := false
var player: CharacterBody2D
var follow_speed := 200
var cat_name :=0
@onready var _animation_player = $AnimationPlayer

func _ready():
	player = get_tree().get_first_node_in_group("player")
	print("player pos: " + str(player.global_position))
	add_to_group("cats")
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not player or not following:
		return
	var direction_x = sign(player.global_position.x - global_position.x)
	if direction_x < 0:
		$Sprite2D.flip_h = true
	var vel = state.linear_velocity
	vel.x = direction_x * follow_speed
	state.linear_velocity = vel
	_animation_player.play("walk0")
		
