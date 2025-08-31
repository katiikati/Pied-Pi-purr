extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -900.0

@export var note_scene: PackedScene
var notes = []
var max_notes = 5
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("Interact"):
		spawn_note()
		for cat in get_tree().get_nodes_in_group("cats"):
			var notifier = cat.get_node("VisibleOnScreenNotifier2D")
			if notifier.is_on_screen():
				cat.sleeping = false
				cat.following = true
		
func spawn_note():
	var note = note_scene.instantiate()
	get_parent().add_child(note)
	note.global_position = global_position
	notes.append(note)
	note.get_node("AudioStreamPlayer").play()
	
	if notes.size()>max_notes:
		var old_note = notes.pop_front()
		if is_instance_valid(old_note):
			old_note.queue_free()
