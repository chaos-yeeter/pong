extends CharacterBody2D

@export var movement_speed: float = 200

var initial_position: Vector2

func get_random_velocity():
	return Vector2(randf_range(0.7, 0.8), randf_range(-0.7, 0.7)) * movement_speed

func reset():
	self.set_position(initial_position)
	velocity = get_random_velocity()

func _ready():
	velocity = get_random_velocity()
	initial_position = self.get_position()
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
