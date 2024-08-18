extends Control

class_name Monster

# Refence vars
var level

# Default place holder stats
@export var NAME = "DEFAULT"
@export var HEALTH = 10
@export var ATTACK = 0
@export var SCORE = 3
@export var ESSENCE = ""
@export var IMG_PATH = ""

# Common monster vars
var hitSound
var sprite

func _init():
	assert(self != Monster, "Monster is an abstract class and cannot be instantiated directly.")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load image
	load_sprite()
	
	# Set health bar up
	$VBoxContainer/HealthBar.max_value = HEALTH
	$VBoxContainer/HealthBar.value = HEALTH
	$VBoxContainer/Label.text = str(HEALTH) + "HP"
	
	# Setup sounds
	load_sounds()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func load_sprite():
	#sprite = Sprite2D.new()
	#sprite.position = Vector2(-6, 36)
	$VBoxContainer/MonsterSprite.position = Vector2(-6, 38)
	var texture = load(IMG_PATH)
	if texture:
		# var spriteNode = get_node("VBoxContainer/MonsterSprite")
		#sprite.texture = texture
		$VBoxContainer/MonsterSprite.texture = texture
	else:
		print("Error: Could not load texture at path:", IMG_PATH)
	add_child(sprite)
	
func load_sounds():
	hitSound = AudioStreamPlayer2D.new()
	hitSound.stream = load("res://audio/effects/hitHurt.wav")

func dealDamage(card, damage) -> void:
	hitSound.play()
	$VBoxContainer/HealthBar.value = $VBoxContainer/HealthBar.value - damage
	$VBoxContainer/Label.text = str($VBoxContainer/HealthBar.value) + "HP"
	if $VBoxContainer/HealthBar.value <= 0:
		defeated(card)

func setLevel(levelRef) -> void:
	level = levelRef

func defeated(card) -> void:
	print("Monster defeated")
	card.setEssence(ESSENCE)
	level.addScore(SCORE)
	
	# Erase self and references
	queue_free()
	level.currentMonster = null

func attack() -> void:
	level.decreaseScore(ATTACK)
