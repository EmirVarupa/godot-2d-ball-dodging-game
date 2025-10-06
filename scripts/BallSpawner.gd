extends Node2D

@onready var spawn_timer = $SpawnTimer

var ball_scene = preload("res://scenes/Ball.tscn")
var screen_size: Vector2

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	spawn_timer.wait_time = 0.5
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func start_spawning():
	spawn_timer.start()

func stop_spawning():
	spawn_timer.stop()

func _on_spawn_timer_timeout():
	spawn_ball()

func spawn_ball():
	var ball = ball_scene.instantiate()
	get_parent().add_child(ball)

	var spawn_position = get_random_spawn_position()
	ball.global_position = spawn_position

	var direction = get_direction_to_screen_center(spawn_position)
	ball.initialize(direction)

func get_random_spawn_position() -> Vector2:
	var margin = 100
	var side = randi() % 4

	match side:
		0: # Top
			return Vector2(randf() * screen_size.x, -margin)
		1: # Right
			return Vector2(screen_size.x + margin, randf() * screen_size.y)
		2: # Bottom
			return Vector2(randf() * screen_size.x, screen_size.y + margin)
		3: # Left
			return Vector2(-margin, randf() * screen_size.y)
		_:
			return Vector2.ZERO

func get_direction_to_screen_center(spawn_pos: Vector2) -> Vector2:
	var screen_center = screen_size / 2
	var direction = (screen_center - spawn_pos).normalized()

	var angle_variance = PI / 4
	var random_angle = randf_range(-angle_variance, angle_variance)
	direction = direction.rotated(random_angle)

	return direction
