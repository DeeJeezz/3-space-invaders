class_name HUD
extends CanvasLayer

@export var score_label: Label
@export var hp_label: Label

var _current_score: int = 0
var _target_score: int = 0


func _process(_delta: float) -> void:
	if _current_score < _target_score:
		if get_tree().get_frame() % 2 == 0:
			_current_score += 5
			_set_score(_current_score)


func set_score(score: int) -> void:
	_current_score = Session.current_score
	_target_score = score


func set_hp(hp: int) -> void:
	hp_label.text = "HP: %d" % hp


func _set_score(score: int) -> void:
	score_label.text = "Score %d" % score
