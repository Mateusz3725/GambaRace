extends Control

@onready var choose_loser: OptionButton = $ChooseLoser
@onready var choose_winner: OptionButton = $ChooseWinner

@onready var spin_box_loser: SpinBox = $SpinBoxLoser
@onready var spin_box_winner: SpinBox = $SpinBoxWinner

@onready var money: Label = $Money
@onready var info: Label = $Info
@onready var loser_info: Label = $LoserInfo

func _ready() -> void:
	if GameManager.money - GameManager.bet_winner >= 0:
		money.text = "Your money:  " + str(GameManager.money - GameManager.bet_winner)
	else:
		money.text = "Your money:   0"
	
	if GameManager.money == 0:
		info.text = "It seems poverty has visited you!"
	
	if GameManager.difficulty_impossible == true:
		$AudioStreamPlayer2D.play()
	
	if GameManager.round > 0:
		GameManager.bet_loser = 0
		spin_box_loser.value = 0
		loser_info.text = "Loser: " + GameManager.loser
	
	spin_box_loser.max_value = GameManager.money
	spin_box_winner.max_value = GameManager.money

	spin_box_loser.value = GameManager.bet_loser
	spin_box_winner.value = GameManager.bet_winner

	spin_box_winner.max_value = GameManager.money - spin_box_loser.value
	spin_box_loser.max_value = GameManager.money - spin_box_winner.value

	choose_loser.clear()
	choose_loser.add_item("Choose the loser")

	for racer_scene in GameManager.active_racers:
		var temp_instance = racer_scene.instantiate()
		choose_loser.add_item(temp_instance.racer_name)
		temp_instance.queue_free()


	choose_winner.clear()
	choose_winner.add_item("Choose the winner")

	for racer_scene in GameManager.all_racers:
		var temp_instance = racer_scene.instantiate()
		choose_winner.add_item(temp_instance.racer_name)
		temp_instance.queue_free()


	if GameManager.round > 0:

		choose_winner.disabled = true
		spin_box_winner.editable = false

		for i in range(choose_winner.item_count):
			if choose_winner.get_item_text(i) == GameManager.gamba_winner:
				choose_winner.select(i)
				break



func _on_button_pressed() -> void:

	var total_bet = spin_box_winner.value + spin_box_loser.value

	if total_bet > GameManager.money:
		info.text = "It seems poverty has visited you!"
		return

	if choose_loser.selected == 0:
		info.text = "Choose the loser!"
		return

	if GameManager.round == 0 and choose_winner.selected == 0:
		info.text = "Choose the winner!"
		return

	if GameManager.gamba_loser == GameManager.gamba_winner:
		info.text = "The winner and the loser cannot be the same."
		return

	GameManager.bet_loser = spin_box_loser.value
	GameManager.bet_winner = spin_box_winner.value
	

	GameManager.loser = ""

	var chosen_map = GameManager.maps.pick_random()
	get_tree().change_scene_to_file(chosen_map)



func _on_choose_loser_item_selected(index: int) -> void:
	var selected_text = choose_loser.get_item_text(index)
	GameManager.gamba_loser = selected_text


func _on_choose_winner_item_selected(index: int) -> void:
	var selected_text = choose_winner.get_item_text(index)
	GameManager.gamba_winner = selected_text



func _on_spin_box_loser_value_changed(value: float) -> void:
	spin_box_winner.max_value = GameManager.money - value
	


func _on_spin_box_winner_value_changed(value: float) -> void:
	spin_box_loser.max_value = GameManager.money - value
	


func _on_exit_pressed() -> void:
	GameManager.bet_winner = 0
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_all_racers_mouse_entered() -> void:
	$Container.visible = true


func _on_all_racers_mouse_exited() -> void:
	$Container.visible = false
