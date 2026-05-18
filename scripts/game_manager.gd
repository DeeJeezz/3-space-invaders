class_name GameManager
extends Node2D

@export_category("UI")
@export var hud: HUD

@export_category("Game")
@export var enemy_director: EnemyDirector
@export var player: Player


func _ready() -> void:
	Signals.add_score.connect(_on_add_score)
	player.ship.hit.connect(_on_player_take_hit)

	enemy_director.start()
	
	hud.set_hp(player.ship.max_hp)


func _on_add_score(score: int) -> void:
	hud.set_score(Session.current_score + score)
	Session.current_score += score


func _on_player_take_hit() -> void:
	hud.set_hp(player.hp)
	print('player took hit')
