extends Node3D

@export var target: Node3D
@export var zoom_min: float = 8.0
@export var zoom_max: float = 25.0
@export var zoom_speed: float = 2.0
@export var rotate_speed: float = 0.5
@export var follow_speed: float = 8.0

var current_zoom: float = 15.0
var rotation_y: float = 45.0
var is_rotating: bool = false

@onready var camera := $Camera3D

func _ready() -> void:
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = current_zoom
	# Posición inicial fija para ver el suelo
	global_position = Vector3(-14, 14, -14)
	rotation_degrees = Vector3(-45, 45, 0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			current_zoom = clamp(current_zoom - zoom_speed, zoom_min, zoom_max)
			camera.size = current_zoom
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			current_zoom = clamp(current_zoom + zoom_speed, zoom_min, zoom_max)
			camera.size = current_zoom
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			is_rotating = event.pressed
	if event is InputEventMouseMotion and is_rotating:
		rotation_y -= event.relative.x * rotate_speed * 0.5
		rotation_degrees.y = rotation_y

func _process(delta: float) -> void:
	if target:
		var desired_pos := target.global_position + Vector3(-14, 14, -14)
		global_position = global_position.lerp(desired_pos, follow_speed * delta)
