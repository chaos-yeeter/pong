extends Label

func _ready():
	# validation
	assert(Signals.has_signal("player_scored"), "player_scored signal not found")
	
	# signals
	Signals.player_scored.connect(_increment_score)

	# initialization
	self.set_text("0")

func _increment_score(new_score):
	self.set_text(str(new_score))
