extends Node2D

signal hit

func _ready():
	Input.set_custom_mouse_cursor(null)

func _process(_delta):
	global_position = get_global_mouse_position()
	check_ball_collisions()

func check_ball_collisions():
	var mouse_pos = get_global_mouse_position()
	for ball in get_tree().get_nodes_in_group("balls"):
		if ball.global_position.distance_to(mouse_pos) <= get_ball_radius(ball):
			hit.emit()
			break

func get_ball_radius(ball: RigidBody2D) -> float:
	var collision_shape = ball.get_node("CollisionShape2D")
	var shape = collision_shape.shape as CircleShape2D
	return shape.radius * collision_shape.scale.x
