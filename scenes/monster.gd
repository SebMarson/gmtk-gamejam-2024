extends Control

var HEALTH = 10
var ATTACK = -1
var SCORE = 3
var ESSENCE = "STRONG"
var level

var hitSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/HealthBar.max_value = HEALTH
	$VBoxContainer/HealthBar.value = HEALTH
	$VBoxContainer/Label.text = str(HEALTH) + "HP"
	hitSound = $HitHurt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

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
