extends RefCounted

class_name Essence

@export var name: String
@export var description: String
@export var power: int
@export var shaderPath: String

var shader

func _init() -> void:
	loadShader()
	
func loadShader() -> void:
	var shader_code: Shader = load(shaderPath)
	shader = ShaderMaterial.new()
	shader.shader = shader_code
	
# Performs some action after a card has been played
func executeCardPlayed(level, monster, card) -> void:
	pass

# Performs some action after mitosis on a card
func executeCardMitosis(level, originalCard, newCardArray) -> void:
	pass
