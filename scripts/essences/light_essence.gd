extends Essence

class_name LightEssence

func _init() -> void:
	name = "LIGHT"
	description = "Blinds enemy for 1 turn"
	power = 0
	shaderPath = "res://shaders/light.gdshader"
	loadResources()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass
