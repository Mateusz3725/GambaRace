extends Node2D

@onready var spawner: Node2D = $Spawner
@onready var balls: Node2D = $Balls


var round_finished := false
func _ready() -> void:
	print("===============")
	print(GameManager.money)
	print("===============")
	print("Gamba loser " + GameManager.gamba_loser)
	print("Loser " + GameManager.loser)
	print("===============")
	print("Gamba winner " + GameManager.gamba_winner)
	print("Winner " + GameManager.winner)
	
	spawn_balls()
	start_temp_timer()



func _physics_process(delta: float) -> void:

	if not round_finished and balls.get_child_count() == 1:
		round_finished = true
		handle_round_end()
		
	



func handle_round_end():
	var last_ball = balls.get_children()[0]
	GameManager.loser = last_ball.racer_name
	
	_loser_money()


	GameManager.active_racers = GameManager.next_round.duplicate()
	GameManager.next_round.clear()
	

	if GameManager.active_racers.size() > 1:
		GameManager.round += 1
		GameManager.start = false
		get_tree().change_scene_to_file("res://Scenes/GambaUI.tscn")
	else:
		_winner_money()
		# Koniec turnieju
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")




func spawn_balls():
	var racers = GameManager.active_racers.duplicate()
	var markers = spawner.get_children()
	markers.shuffle()

	for marker in markers:
		if racers.size() > 0:
			var racer = racers.pick_random()
			racers.erase(racer)

			var ball = racer.instantiate()
			ball.global_position = marker.global_position
			balls.add_child(ball)




func start_temp_timer():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	add_child(timer)

	timer.timeout.connect(_on_timer_timeout.bind(timer))
	timer.start()


func _on_timer_timeout(timer):
	GameManager.start = true
	timer.queue_free()

func _loser_money():
	if GameManager.loser == "":
		return
	
	var multiplier = get_loser_multiplier()
	
	if GameManager.gamba_loser == GameManager.loser:
		GameManager.money += GameManager.bet_loser * multiplier
	else:
		GameManager.money -= GameManager.bet_loser

func _winner_money():
	if GameManager.winner == "":
		return
	
	
	if GameManager.gamba_winner == GameManager.winner:
		GameManager.money += GameManager.bet_winner * 8
	else:
		GameManager.money -= GameManager.bet_winner

func get_loser_multiplier():
	return GameManager.active_racers.size() - 1
