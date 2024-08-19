extends RefCounted

class_name Essence

@export var name: String
@export var description: String
@export var power: int
@export var shaderPath: String
@export var partialShaderPath: String
@export var cardSpritePath: String

var shader
var partialShader
var cardSprite

func _init() -> void:
	loadResources()
	
func loadResources() -> void:
	loadShaders()
	loadSprites()
	
func loadSprites() -> void:
	cardSprite = ImageTexture.create_from_image(Image.load_from_file(cardSpritePath))
	
func loadShaders() -> void:
	var shader_code: Shader = load(shaderPath)
	shader = ShaderMaterial.new()
	shader.shader = shader_code
	
	var partial_shader_code: Shader = load(partialShaderPath)
	partialShader = ShaderMaterial.new()
	partialShader.shader = partial_shader_code
	
# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass

# Performs some action during the draw phase
func executeCardDraw(level, deck) -> Array:
	var drawnCards = []
	return drawnCards
