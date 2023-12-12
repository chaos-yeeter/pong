extends CharacterBody2D

const MAX_SPEED: float = 100
const ACCELERATION: float = 5
const LOOK_AHEAD: int = 300

var viewport_dimensions: Vector2i = DisplayServer.window_get_size()
var viewport_height: int = viewport_dimensions.y
var _initial_position: Vector2
var _final_ball_position: Vector2

func _ready():
	# validations
	assert(Signals.has_signal("ball_hit_death_zone"), "Create signal ball_hit_death_zone")
	assert(Signals.has_signal("ball_position_changed"), "Create signal ball_position_changed")
	
	# signals
	Signals.ball_hit_death_zone.connect(_reset)
	Signals.ball_position_changed.connect(_on_ball_position_changed)

	# initialization
	_initial_position = self.get_position()

func _process(_delta):
	var movement_factor = abs(_final_ball_position.y - self.get_position().y)
	var target_velocity =  movement_factor * (_final_ball_position - self.get_position())
	target_velocity = target_velocity.clamp(
		Vector2.UP * MAX_SPEED,
		Vector2.DOWN * MAX_SPEED
	)
	velocity = velocity.move_toward(target_velocity, ACCELERATION)
	move_and_slide()

func _reset(_body):
	velocity = Vector2.ZERO
	self.set_position(_initial_position)

func _on_ball_position_changed(ball_position: Vector2, ball_velocity: Vector2):
	# skip calculation if ball is not coming towards ai
	if ball_velocity.x >= 0:
		return
	var estimated_ball_position = ball_position + ball_velocity * LOOK_AHEAD
	estimated_ball_position = Vector2(
		0,
		ball_position.y \
		- (
			(estimated_ball_position.y - ball_position.y) \
			/ (estimated_ball_position.x - ball_position.x) \
			* ball_position.x
		)
	)
	if estimated_ball_position.y >= 0 and estimated_ball_position.y <= viewport_height:
		_final_ball_position = estimated_ball_position
		return
	var estimated_total_distance = estimated_ball_position.distance_to(ball_position)
	var ball_direction = Vector2.UP
	if ball_velocity.y > 0:
		ball_direction = Vector2.DOWN
	var distance_to_first_bounce: float
	var theta: float = abs(PI / 2 - abs(ball_velocity.angle()))
	if ball_direction == Vector2.UP:
		distance_to_first_bounce = ball_position.y / cos(theta)
	else:
		distance_to_first_bounce = (viewport_height - ball_position.y) / cos(theta)
	var max_distance_to_bounce = viewport_height / cos(theta)
	var num_bounces = floori((estimated_total_distance - distance_to_first_bounce) / max_distance_to_bounce)
	var will_ball_bounce_even_times: bool = num_bounces % 2 == 0
	var remaining_distance_after_bounces = fmod((estimated_total_distance - distance_to_first_bounce), max_distance_to_bounce)
	if (
		(ball_direction == Vector2.UP and will_ball_bounce_even_times)
		or (ball_direction == Vector2.DOWN and not will_ball_bounce_even_times)
	): # last bounce on top boundary
		_final_ball_position = Vector2(
			estimated_ball_position.x,
			remaining_distance_after_bounces * cos(theta)
		)
	else: # last bounce on bottom boundary
		_final_ball_position = Vector2(
			estimated_ball_position.x,
			(viewport_height - remaining_distance_after_bounces * cos(theta))
		)
