extends Essence

class_name StrongEssence

func _init() -> void:
	name = "STRONG"
	description = "No power split after mitosis"
	power = 0
	shaderPath = "res://shaders/strong.gdshader"
	loadShader()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass
	
	
# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	for card in newCardArray:
		card.power = originalCard.power
