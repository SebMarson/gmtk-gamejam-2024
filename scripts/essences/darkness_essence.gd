extends Essence

class_name DarknessEssence

func _init() -> void:
	name = "DARKNESS"
	description = "Multiply damage of next card"
	power = 0
	shaderPath = "res://shaders/darkness.gdshader"
	loadShader()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass
