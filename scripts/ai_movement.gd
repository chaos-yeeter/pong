extends CharacterBody2D

@export var movement_speed: float = 100
@export var acceleration: float = 1.5
@export var ball: CharacterBody2D


func _process(delta):
	var current_y_position = self.get_position().y
	var ball_y_position = ball.get_position().y
	var movement_direction = Vector2(
		0,
		(ball_y_position - current_y_position) / abs(ball_y_position - current_y_position)
	)
	velocity = velocity.move_toward(movement_direction * movement_speed, acceleration)
	move_and_slide()
