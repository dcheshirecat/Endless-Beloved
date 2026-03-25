# MinigameResult.gd
# Result screen shown after minigame completion
extends Control

@onready var title_label = $Panel/VBoxContainer/TitleLabel
@onready var score_label = $Panel/VBoxContainer/ScoreLabel
@onready var continue_button = $Panel/VBoxContainer/ContinueButton

signal continue_pressed

func setup(title: String, score: int, max_score: int) -> void:
	title_label.text = title + " Complete!"
	score_label.text = "Score: %d/%d" % [score, max_score]

func _on_continue_button_pressed() -> void:
	continue_pressed.emit()
