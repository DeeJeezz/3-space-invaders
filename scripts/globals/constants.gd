extends Node

const AVAILABLE_RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1280, 720),
]

const MASTER_AUDIO_BUS_NAME: String = "Master"
const GAME_SCENE_PATH: String = "res://scenes/game.tscn"
const ENEMY_SCENE_PATH: String = "res://scenes/enemy.tscn"

#region Ships
enum ShipType {
	FREGATE,
	TROOPER,
	MARAUDER,
}

var ENEMIES_SHIP_TYPES: Array[Constants.ShipType] = [ShipType.MARAUDER]

const FREGATE_SHIP_SCENE_PATH: String = "res://scenes/ships/player/fregate/fregate.tscn"
const FREGATE_BULLET_SCENE_PATH: String = "res://scenes/ships/player/fregate/fregate_bullet.tscn"

const TROOPER_SHIP_SCENE_PATH: String = "res://scenes/ships/player/trooper/trooper.tscn"
const TROOPER_BULLET_SCENE_PATH: String = "res://scenes/ships/player/trooper/trooper_bullet.tscn"

const MARAUDER_SHIP_SCENE_PATH: String = "res://scenes/ships/enemy/marauder/marauder.tscn"
const MARAUDER_BULLET_SCENE_PATH: String = "res://scenes/ships/enemy/marauder/marauder_bullet.tscn"

const PLAYER_SHIPS_SCENES: Dictionary[ShipType, String] = {
	ShipType.FREGATE: FREGATE_SHIP_SCENE_PATH,
	ShipType.TROOPER: TROOPER_SHIP_SCENE_PATH,
}
const ENEMY_SHIPS_SCENES: Dictionary[ShipType, String] = {
	ShipType.MARAUDER: MARAUDER_SHIP_SCENE_PATH,
}
#endregion

#region Explosions
const _EXPLOSION_1_SPRITE_FRAMES_PATH: String = "res://resources/img/misc/explosion1.tres"
const _EXPLOSION_2_SPRITE_FRAMES_PATH: String = "res://resources/img/misc/explosion2.tres"

const EXPLOSIONS: Array[String] = [
	_EXPLOSION_1_SPRITE_FRAMES_PATH,
	_EXPLOSION_2_SPRITE_FRAMES_PATH,
]
#endregion

#region UI
const CHOOSE_SHIP_SCENE_PATH: String = "res://scenes/ui/choose_ship_menu.tscn"
const OPTIONS_SCENE_PATH: String = "res://scenes/ui/options_menu.tscn"
const MAIN_MENU_SCENE_PATH: String = "res://scenes/ui/main_menu.tscn"
#endregion
