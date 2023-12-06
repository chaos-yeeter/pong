extends Node

func _ready():
	Signals.ball_hit_death_zone.connect(_handle_score)

func _handle_score(lost_character: Node2D):
	if lost_character.get_name() == "ai":
		Signals.player_scored.emit()
	elif lost_character.get_name() == "player":
		Signals.ai_scored.emit()
