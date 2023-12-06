extends Label

func _ready():
	# validation
	assert(Signals.has_signal("ai_scored"), "ai_scored signal not found")
	
	# signals
	Signals.ai_scored.connect(_increment_score)

	# initialization
	self.set_text("0")

func _increment_score():
	var new_score = int(self.get_text()) + 1
	self.set_text(str(new_score))
