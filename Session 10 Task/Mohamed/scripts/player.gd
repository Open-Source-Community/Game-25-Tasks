extends CharacterBody3D


const SPEED = 25.0
const JUMP_VELOCITY = 120.0
const mouse_sen = 0.02
var y_rotation := 0.0
var camera_x_rotation := 0.0
var limit_camera_angle := 70

@onready var cam: Camera3D = $Camera3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		y_rotation -= event.relative.x * mouse_sen
		rotation.y = y_rotation
		camera_x_rotation -= event.relative.y * mouse_sen
		camera_x_rotation = clamp(camera_x_rotation, deg_to_rad(-limit_camera_angle), deg_to_rad(limit_camera_angle))
		cam.rotation.x = camera_x_rotation

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.z = direction.z * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
