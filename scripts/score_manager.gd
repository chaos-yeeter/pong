extends Node

var _scores: Dictionary

func _ready():
	# validation
	assert(Signals.has_signal("ball_hit_death_zone"), "Signal ball_hit_death_zone not found")

	# initialization
	_scores = {
		"ai": 0,
		"player": 0,
	}

	# signals
	Signals.ball_hit_death_zone.connect(_handle_score)

func _handle_score(lost_character: Node2D):
	var lost_character_name = lost_character.get_name()
	assert(
		lost_character_name == "ai" or lost_character_name == "player",
		"lost_character ('%s') must be either ai or player" % lost_character_name
	)

	if lost_character_name == "ai":
		_scores["player"] = _scores["player"] + 1
		Signals.player_scored.emit(_scores["player"])
	elif lost_character_name == "player":
		_scores["ai"] = _scores["ai"] + 1
		Signals.ai_scored.emit(_scores["ai"])
