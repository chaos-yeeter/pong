extends CharacterBody2D

const MOVEMENT_TIME: float = 8
const MAX_SPEED: float = 150
const ACCELERATION: float = 5
const BALL_PROXIMITY_THRESHOLD: int = 50
const LOOK_AHEAD: int = 4

var viewport_height: int = DisplayServer.window_get_size().y
var _initial_position: Vector2
var _target_position: Vector2

func _ready():
	# validations
	assert(Signals.has_signal("ball_hit_death_zone"), "Create signal ball_hit_death_zone")
	assert(Signals.has_signal("ball_position_changed"), "Create signal ball_position_changed")
	
	# signals
	Signals.ball_hit_death_zone.connect(_reset)
	Signals.ball_position_changed.connect(_on_ball_position_changed)

	# initialization
	_initial_position = self.get_position()

func _process(delta):
	velocity = (_target_position - self.get_position()) / MOVEMENT_TIME
	velocity = velocity.clamp(Vector2.UP * MAX_SPEED, Vector2.DOWN * MAX_SPEED)
	move_and_slide()

func _reset(_body):
	velocity = Vector2.ZERO
	self.set_position(_initial_position)

func _on_ball_position_changed(ball_position: Vector2, ball_velocity: Vector2):
	var look_ahead = LOOK_AHEAD
	if ball_position.x - self.get_position().x < BALL_PROXIMITY_THRESHOLD:
		look_ahead = 1
	var future_ball_position = ball_position + ball_velocity * look_ahead
	var target_y_position = int(future_ball_position.y)
	var total_bounces = int(target_y_position / viewport_height)
	var remaining_distance_after_bounces = target_y_position % viewport_height
	_target_position = Vector2(_initial_position.x, target_y_position)
