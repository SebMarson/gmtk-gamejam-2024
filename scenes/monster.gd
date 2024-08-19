extends Control

class_name Monster

# Refence vars
var level

# Default place holder stats
@export var NAME = "DEFAULT"
@export var HEALTH = 10
@export var ATTACK = 0
@export var SCORE = 3
@export var ESSENCENAME = ""
@export var IMG_PATH = ""
@export var EXTRASCALE: float = 3
@export var SCALEMIN: float = 0.3
@export var SCALEMAX: float = 3

# Common monster vars
var hitSound
var sprite
var essence

func _init():
	assert(self != Monster, "Monster is an abstract class and cannot be instantiated directly.")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load properties
	load_sprite()
	load_essence()
	
	# Set health bar up
	$VBoxContainer/HealthBar.max_value = HEALTH
	$VBoxContainer/HealthBar.value = HEALTH
	$VBoxContainer/Label.text = str(HEALTH) + "HP"
	#$VBoxContainer/Name.custom_minimum_size = Vector2(100, 100)
	$VBoxContainer/Name.text = str(NAME)
	
	# Setup sounds
	load_sounds()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Have the skew and position change slightly here to simulate movement... Or acutally animate it?
	pass
	
func load_sprite():
	var texture = load(IMG_PATH)
	if texture:
		$VBoxContainer/MonsterSprite.texture = texture
	else:
		print("Error: Could not load texture at path:", IMG_PATH)
		
	# Scale image based on the players current score
	var scaleFactor: float = (float(HEALTH)/float(level.score)) * EXTRASCALE
	if scaleFactor < 1:
		scaleFactor = max(SCALEMIN, scaleFactor)
	else:
		scaleFactor = min(SCALEMAX, scaleFactor)
	$VBoxContainer/MonsterSprite.scale = Vector2(scaleFactor, scaleFactor)
	
func load_essence() -> void:
	if (ESSENCENAME != null):
		essence = level.essenceManager.getEssence(ESSENCENAME)
	
func load_sounds():
	hitSound = $HitHurt

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
	card.defeatedMonster(self)
	level.addScore(SCORE)
	
	# Set flags if boss monster
	if (self.NAME == "EUROPE"):
		level.europeFlag = true
	elif (self.NAME == "EARTH"):
		level.earthFlag = true
	elif (self.NAME == "SUN"):
		level.sunFlag = true
		
	# Erase self and references
	queue_free()
	level.currentMonster = null

func attack() -> void:
	level.decreaseScore(ATTACK)
