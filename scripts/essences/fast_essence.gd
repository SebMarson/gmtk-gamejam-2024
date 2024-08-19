extends Essence

class_name FastEssence

func _init() -> void:
	name = "FAST"
	description = "Fast cards will always be drawn before regular ones"
	power = 0
	shaderPath = "res://shaders/fast.gdshader"
	loadResources()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass
