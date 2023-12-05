extends CharacterBody2D

@export var ball: CharacterBody2D

const MOVEMENT_SPEED: float = 100
const ACCELERATION: float = 32

var _initial_position: Vector2

func reset():
	velocity = Vector2.ZERO
	self.set_position(_initial_position)

func _ready():
	_initial_position = self.get_position()
	assert(ball != null, "Assign ball to %s" % self.get_name())

func _process(_delta):
	# run computation once every x frames
	if Engine.get_frames_drawn() % 10 == 0:
		var current_y_position = self.get_position().y
		var ball_y_position = ball.get_position().y
		# get unit vector in the direction of ball
		var movement_direction = Vector2(
			0,
			(ball_y_position - current_y_position) / abs(ball_y_position - current_y_position)
		)
		velocity = velocity.move_toward(movement_direction * MOVEMENT_SPEED, ACCELERATION)
	move_and_slide()
