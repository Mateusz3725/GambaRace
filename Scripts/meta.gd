extends Node2D

@onready var meta: Node2D = $"."

@export var moving := false
@export var speed := 150

@onready var point_a = $PointA
@onready var point_b = $PointB

var pos_a : Vector2
var pos_b : Vector2
var target : Vector2



func _ready() -> void:
	pos_a = point_a.global_position
	pos_b = point_b.global_position
	
	target = pos_b


func _process(delta: float) -> void:
	if not moving:
		return
	
	global_position = global_position.move_toward(target, speed * delta)
	
	if global_position.distance_to(target) < 5:
		if target == pos_a:
			target = pos_b
		else:
			target = pos_a
