extends Control

var HEALTH = 5
var level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/HealthBar.max_value = HEALTH
	$VBoxContainer/HealthBar.value = HEALTH
	$VBoxContainer/Label.text = str(HEALTH) + "HP"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dealDamage(damage) -> void:
	$VBoxContainer/HealthBar.value = $VBoxContainer/HealthBar.value - damage
	$VBoxContainer/Label.text = str($VBoxContainer/HealthBar.value) + "HP"
	if $VBoxContainer/HealthBar.value <= 0:
		print("Monster defeated")
		defeated()

func setLevel(levelRef) -> void:
	level = levelRef

func defeated() -> void:
	queue_free()
	level.addScore(1)
	level.spawnMonster()
