extends Node

var _scores: Dictionary
var _loser_to_winner_mapping: Dictionary

func _ready():
	# validation
	assert(Signals.has_signal("ball_hit_death_zone"), "Signal ball_hit_death_zone not found")

	# initialization
	_scores = {
		"ai": 0,
		"player": 0,
	}
	_loser_to_winner_mapping = {
		"ai": "player",
		"player": "ai",
	}

	# signals
	Signals.ball_hit_death_zone.connect(_handle_score)

func _handle_score(lost_character: Node2D):
	var loser_name = lost_character.get_name()
	assert(
		loser_name == "ai" or loser_name == "player",
		"lost_character ('%s') must be either ai or player" % loser_name
	)
	
	var winner_name = _loser_to_winner_mapping[loser_name]
	_scores[winner_name] = _scores[winner_name] + 1

	if winner_name == "player":
		Signals.player_scored.emit(_scores[winner_name])
	elif winner_name == "ai":
		Signals.ai_scored.emit(_scores[winner_name])
