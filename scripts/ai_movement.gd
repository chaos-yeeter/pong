extends CharacterBody2D

@export var movement_speed: float = 100

var speed: Vector2 = Vector2(0, movement_speed)

func _process(delta):
	if get_slide_collision_count() > 0:
		speed = speed * -1
	velocity = speed
	move_and_slide()
