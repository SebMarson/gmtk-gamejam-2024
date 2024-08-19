extends Essence

class_name DarknessEssence

func _init() -> void:
	name = "DARKNESS"
	essenceDescription = "After mitosis new cards power will be increased by a random number between 0.5 and 2"
	effectDescription = "Multiply this cards power by a random number between 0.5 and 2"
	power = 0
	shaderPath = "res://shaders/darkness.gdshader"
	partialShaderPath = "res://shaders/darkness_partial.gdshader"
	cardSpritePath = "res://graphics/cards/darkness-card.png"
	loadResources()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass
