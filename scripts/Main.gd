extends Node2D

enum GameState { PLAYING, GAME_OVER }

@onready var player = $Player
@onready var ball_spawner = $BallSpawner
@onready var ui = $UI
@onready var score_timer = $ScoreTimer

var current_state = GameState.PLAYING
var score = 0

func _ready():
	start_game()

func start_game():
	current_state = GameState.PLAYING
	score = 0
	ui.update_score(score)
	ui.hide_game_over()
	score_timer.start()
	ball_spawner.start_spawning()

	for ball in get_tree().get_nodes_in_group("balls"):
		ball.queue_free()

func game_over():
	current_state = GameState.GAME_OVER
	score_timer.stop()
	ball_spawner.stop_spawning()

	for ball in get_tree().get_nodes_in_group("balls"):
		ball.freezes = true

	ui.show_game_over()

func _input(event):
	if current_state == GameState.GAME_OVER and event is InputEventMouseButton and event.pressed:
		start_game()

func _on_score_timer_timeout():
	if current_state == GameState.PLAYING:
		score += 1
		ui.update_score(score)

func _on_player_hit():
	game_over()
