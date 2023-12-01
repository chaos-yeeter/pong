extends CharacterBody2D

@export var movement_speed: float = 100
@export var acceleration: float = 32
@export var ball: CharacterBody2D

var initial_position: Vector2

func reset():
	velocity = Vector2.ZERO
	self.set_position(initial_position)

func _ready():
	initial_position = self.get_position()
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
		velocity = velocity.move_toward(movement_direction * movement_speed, acceleration)
	move_and_slide()
