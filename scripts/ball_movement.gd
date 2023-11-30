extends CharacterBody2D

@export var movement_speed: float = 250

func _ready():
	velocity = Vector2(randf_range(0.1, 0.7), randf_range(0.1, 0.7)) * movement_speed

	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
