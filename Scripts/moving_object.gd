extends CharacterBody2D


@export var point_a: Marker2D
@export var point_b: Marker2D
@export var speed := 200

var pos_a: Vector2
var pos_b: Vector2
var target: Vector2

func _ready() -> void:
	pos_a = point_a.global_position
	pos_b = point_b.global_position
	
	target = pos_b


func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target, speed * delta)

	if global_position.distance_to(target) < 5:
		if target == pos_a:
			target = pos_b
		else:
			target = pos_a
