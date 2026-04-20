extends Node2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	GameManager.round = 0
	GameManager.winner = ""
	GameManager.active_racers = GameManager.all_racers.duplicate()
	get_tree().change_scene_to_file("res://Scenes/GambaUI.tscn")


func _on_button_2_pressed() -> void:
	GameManager.money = 1000
	GameManager.save_game()


func _on_button_3_pressed() -> void:
	if GameManager.difficulty_impossible == false:
		GameManager.difficulty_impossible = true
		$AudioStreamPlayer2D.play()
		$Panel/Button3.text = "PLEASE STOP!"
	else:
		GameManager.difficulty_impossible = false
		$AudioStreamPlayer2D.stop()
		$Panel/Button3.text = "MUSIC: ON"
			






func _on_button_3_mouse_entered() -> void:
	$Label/Label.text = "En: 
		Hey, don't do it. Listening to this is physically painful. Just throw on some YouTube or Spotify instead.
	
	Pl: 
		Hej, nie radzę - grozi udarem. Lepiej włącz w tle YouTube albo Spotify."
	$Label/PanelContainer.visible = true


func _on_button_3_mouse_exited() -> void:
	$Label/Label.text = ""
	$Label/PanelContainer.visible = false
