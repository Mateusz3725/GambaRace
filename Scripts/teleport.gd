extends Area2D

@export var moving := false
@export var speed := 150

@export var exit_moving := false
@export var exit_speed := 150

@onready var point_a: Marker2D = $PointA
@onready var point_b: Marker2D = $PointB

@onready var exit_point: Marker2D = $ExitPoint
@onready var exit_a: Marker2D = $ExitA
@onready var exit_b: Marker2D = $ExitB

var pos_a: Vector2
var pos_b: Vector2
var target: Vector2
var pos_end: Vector2 # Ta zmienna będzie teraz dynamiczna

var exit_pos_a: Vector2
var exit_pos_b: Vector2
var exit_target: Vector2

func _ready():
	pos_a = point_a.global_position
	pos_b = point_b.global_position
	target = pos_b

	exit_pos_a = exit_a.global_position
	exit_pos_b = exit_b.global_position
	exit_target = exit_pos_b
	
	# Początkowe przypisanie
	pos_end = exit_point.global_position

func _process(delta):
	# Ruch wejścia teleportu
	if moving:
		global_position = global_position.move_toward(target, speed * delta)
		if global_position.distance_to(target) < 5:
			target = pos_a if target == pos_b else pos_b

	# Ruch wyjścia teleportu
	if exit_moving:
		exit_point.global_position = exit_point.global_position.move_toward(exit_target, exit_speed * delta)
		if exit_point.global_position.distance_to(exit_target) < 5:
			exit_target = exit_pos_a if exit_target == exit_pos_b else exit_pos_b
	else:
		return

	# KLUCZOWA ZMIANA: Aktualizujemy pos_end w każdej klatce, 
	# żeby nadążało za ruszającym się markerem ExitPoint.
	pos_end = exit_point.global_position

func _on_body_entered(body: Node2D):
	if not body.is_in_group("racer"):
		return

	await get_tree().physics_frame

	# Zatrzymanie fizyki
	if "linear_velocity" in body:
		body.linear_velocity = Vector2.ZERO
		body.angular_velocity = 0

	# Teraz pos_end ma zawsze świeżą pozycję z _process
	body.global_position = pos_end
