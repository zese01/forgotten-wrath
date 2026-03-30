extends CharacterBody3D

@export var speed: float = 5.0
@export var run_speed: float = 9.0
@export var gravity: float = 20.0

var current_speed: float = speed

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Input de movimiento
	var input := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# Correr con Shift
	current_speed = run_speed if Input.is_action_pressed("ui_accept") else speed

	if input.length() > 0:
		input = input.normalized()
		# Convertir input 2D a movimiento isométrico 3D
		var direction := Vector3(
			input.x - input.y,
			0,
			input.x + input.y
		).normalized()
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed

		# Rotar el personaje hacia donde se mueve
		var target_angle := atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, 0.15)
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()de
