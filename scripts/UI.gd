extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_label = $GameOverPanel/GameOverLabel
@onready var restart_label = $GameOverPanel/RestartLabel

func update_score(new_score: int):
	score_label.text = "Score: " + str(new_score)

func show_game_over():
	game_over_panel.visible = true
	restart_label.modulate.a = 0.0

	var fade_tween = create_tween()
	fade_tween.set_loops()
	fade_tween.tween_property(restart_label, "modulate:a", 1.0, 1.0)
	fade_tween.tween_property(restart_label, "modulate:a", 0.3, 1.0)

func hide_game_over():
	game_over_panel.visible = false
