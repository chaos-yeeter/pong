extends CharacterBody2D

const MOVEMENT_SPEED: float = 200

var _initial_position: Vector2

func _get_random_velocity():
	return Vector2(randf_range(0.7, 0.8), randf_range(-0.7, 0.7)) * MOVEMENT_SPEED

func reset():
	self.set_position(_initial_position)
	velocity = _get_random_velocity()

func _ready():
	velocity = _get_random_velocity()
	_initial_position = self.get_position()

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
