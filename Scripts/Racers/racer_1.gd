extends RigidBody2D

@onready var rigid_body_2d: RigidBody2D = $"."
var racer_name = "Pink"


func _ready() -> void:
	pass



func _process(delta: float) -> void:
	if GameManager.start == false:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		gravity_scale = 0
	else:
		gravity_scale = 1.0
		angular_velocity - 1.0

func _on_area_2d_area_entered(area: Area2D) -> void:
	rigid_body_2d.queue_free()
	if GameManager.next_round.size() == 0:
		GameManager.winner = "Pink"
	GameManager.next_round.append(preload("res://Prototypowanie/racer_1.tscn"))
