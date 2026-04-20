extends Node

var all_racers = [
	preload("res://Scenes/Racers/Red.tscn"),
	preload("res://Scenes/Racers/Yellow.tscn"),
	preload("res://Scenes/Racers/Orange.tscn"),
	preload("res://Scenes/Racers/Blue.tscn"),
	preload("res://Scenes/Racers/Green.tscn"),
	preload("res://Scenes/Racers/Pink.tscn"),
	preload("res://Scenes/Racers/Purple.tscn"),
	preload("res://Scenes/Racers/Cyan.tscn"),
	preload("res://Scenes/Racers/Lime.tscn"),
	preload("res://Scenes/Racers/Lavender.tscn")
]

var active_racers = []

var next_round = []

var maps = [
	"res://Scenes/Levels/Level_1.tscn",
	"res://Scenes/Levels/Level_2.tscn",
	"res://Scenes/Levels/Level_3.tscn",
	"res://Scenes/Levels/Level_4.tscn",
	"res://Scenes/Levels/Level_5.tscn",
	"res://Scenes/Levels/Level_6.tscn",
	"res://Scenes/Levels/Level_7.tscn",
	"res://Scenes/Levels/Level_8.tscn",
	"res://Scenes/Levels/Level_9.tscn",
	"res://Scenes/Levels/Level_10.tscn"
]

var round = 0

var start = false

var winner = ""
var gamba_winner = ""

var loser = ""
var gamba_loser = ""

var racer_name = ""

var money = 1000

var bet_loser = 0
var bet_winner = 0

var difficulty_impossible = false

func _ready() -> void:
	active_racers = all_racers


func _process(delta: float) -> void:
	pass


func save_game():
	var data = {
		"money": GameManager.money
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func load_game():
	if not FileAccess.file_exists("user://save.json"):
		return
	
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var text = file.get_as_text()
	var data = JSON.parse_string(text)
	
	if data == null:
		return
	
	money = data.get("money", 0)
