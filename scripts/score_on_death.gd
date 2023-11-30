extends Area2D

@export var ball: CharacterBody2D
@export var opponents_score_label: Label

func _ready():
	assert(ball != null, "Assign Ball to %s" % self.get_name())
	assert(opponents_score_label != null, "Assign Opponents Score Label to to %s" % self.get_name())

func _on_body_entered(body):
	if body.get_name() == ball.get_name():
		var new_score = 1 + int(opponents_score_label.get_text())
		opponents_score_label.set_text(str(new_score))
