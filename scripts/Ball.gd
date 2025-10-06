extends RigidBody2D

@onready var lifetime_timer = $LifetimeTimer
@onready var sprite = $Ball0001
@onready var collision_shape = $CollisionShape2D

var speed = 200.0
var freezes = false
var ball_textures = [
	preload("res://assets/ball-0001.png"),
	preload("res://assets/ball-0002.png"),
	preload("res://assets/ball-0003.png"),
	preload("res://assets/ball-0004.png")
]

func _ready():
	add_to_group("balls")
	lifetime_timer.wait_time = 10.0
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	lifetime_timer.start()

	var random_texture = ball_textures[randi() % ball_textures.size()]
	sprite.texture = random_texture
	sprite.visible = true

	var base_sprite_scale = sprite.scale
	var base_collision_scale = collision_shape.scale

	var random_scale_factor = randf_range(0.5, 1.5)
	sprite.scale = base_sprite_scale * random_scale_factor
	collision_shape.scale = base_collision_scale * random_scale_factor

	collision_layer = 2
	collision_mask = 0

func initialize(direction: Vector2):
	linear_velocity = direction * speed

func _physics_process(_delta):
	if freezes:
		linear_velocity = Vector2.ZERO
		lifetime_timer.paused = true
	else:
		lifetime_timer.paused = false

func _on_lifetime_timeout():
	queue_free()
