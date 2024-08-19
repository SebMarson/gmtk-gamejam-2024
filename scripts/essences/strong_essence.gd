extends Essence

class_name StrongEssence

func _init() -> void:
	name = "STRONG"
	essenceDescription = "Cards generated after mitosis won't decrease in power!"
	effectDescription = "Nothing"
	power = 0
	shaderPath = "res://shaders/strong.gdshader"
	partialShaderPath = "res://shaders/strong_partial.gdshader"
	cardSpritePath = "res://graphics/cards/strong-card.png"
	loadResources()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass
	
	
# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	for card in newCardArray:
		card.power = originalCard.power
