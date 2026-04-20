extends StaticBody2D

@export var speed := 300
@export var rev_side := false

func _physics_process(delta: float) -> void:
	var direction := 1
	
	if rev_side:
		direction = -1
		
	rotation_degrees += speed * direction * delta
