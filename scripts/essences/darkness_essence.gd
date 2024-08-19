extends Essence

class_name DarknessEssence

func _init() -> void:
	name = "DARKNESS"
	essenceDescription = "After mitosis new cards have a chance to hit the enemy twice"
	effectDescription = "This card has a chance to hit to hit twice"
	power = 0
	shaderPath = "res://shaders/darkness.gdshader"
	partialShaderPath = "res://shaders/darkness_partial.gdshader"
	cardSpritePath = "res://graphics/cards/darkness-card.png"
	loadResources()

# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	if (RandomNumberGenerator.new().randi_range(0, 100) > 60):
		monster.HEALTH -= card.power
