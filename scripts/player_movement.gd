extends CharacterBody2D

@export var movement_speed: float = 250
@export var deceleration: float = 10

var initial_position: Vector2

func reset():
	velocity = Vector2.ZERO
	self.set_position(initial_position)

func _ready():
	initial_position = self.get_position()

func _process(_delta):
	velocity = velocity.move_toward(Vector2.ZERO, deceleration)
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP * movement_speed
	elif Input.is_action_pressed("move_down"):
		velocity = Vector2.DOWN * movement_speed
	move_and_slide()
