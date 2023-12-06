extends CharacterBody2D

const MOVEMENT_SPEED: float = 250

var _initial_position: Vector2

func _ready():
	_initial_position = self.get_position()
	_set_random_velocity()
	Signals.ball_hit_death_zone.connect(_reset)

func _reset(_body):
	_set_random_velocity()
	self.set_position(_initial_position)

func _set_random_velocity():
	velocity = Vector2(randf_range(0.4, 0.7), randf_range(-0.7, 0.7)) * MOVEMENT_SPEED

func _process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		move_and_collide(velocity * delta)
	# emit position once every few frames so that others (e.g. ai) can react to
	# it
	if Engine.get_frames_drawn() % 10 == 0:
		Signals.ball_position_changed.emit(self.get_position(), self.get_velocity())
