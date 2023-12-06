extends Area2D

func _ready():
	assert(self.get_parent() != null, "Move %s under a either player or ai" % self.get_name())

func _on_body_entered(body):
	if body.get_name() == "ball":
		Signals.ball_hit_death_zone.emit(self.get_parent())
