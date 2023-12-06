extends CharacterBody2D

const MOVEMENT_SPEED: float = 250
const DECELERATION: float = 10

var _initial_position: Vector2

func _ready():
	_initial_position = self.get_position()
	Signals.ball_hit_death_zone.connect(_reset)

func _reset(_body):
	velocity = Vector2.ZERO
	self.set_position(_initial_position)

func _process(_delta):
	velocity = velocity.move_toward(Vector2.ZERO, DECELERATION)
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP * MOVEMENT_SPEED
	elif Input.is_action_pressed("move_down"):
		velocity = Vector2.DOWN * MOVEMENT_SPEED
	move_and_slide()
