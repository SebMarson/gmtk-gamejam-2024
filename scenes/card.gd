extends Control

var level
var damage
var effect
var essence

func _init() -> void:
	print("Created a card")
	damage = RandomNumberGenerator.new().randi_range(1, 5)
	effect = ""
	essence = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Card drawn")
	custom_minimum_size = $CardSprite.texture.get_size()
	$Label.text = str(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			play_card()

func setLevel(levelRef) -> void:
	level = levelRef
	
func setEssence(ess) -> void:
	print("Card essence set to " + ess)
	essence = ess
	
	# Update shader
	$CardSprite.material = level.shaders.get(ess)
	print("Card sprite material updated")

func play_card() -> void:
	print("Card clicked on")
	if (damage > 0):
		level.currentMonster.dealDamage(self, damage)
	
	# Remove this card from the hand
	#level.hand.cards.erase(self)
	level.hand.removeCard(self)
	
	# Add this card to the discard deck
	level.discardDeck.addCard(self)
	
	# Prompt level to do its post user-go stuff
	level.postUserGo()
