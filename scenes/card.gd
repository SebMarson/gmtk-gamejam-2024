extends Control

var level
var damage
var effect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Created a card")
	custom_minimum_size = $CardSprite.texture.get_size()
	damage = RandomNumberGenerator.new().randi_range(1, 5)
	$Label.text = str(damage)
	effect = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			play_card()

func setLevel(levelRef) -> void:
	level = levelRef

func play_card() -> void:
	print("Card clicked on")
	if (damage > 0):
		level.currentMonster.dealDamage(damage)
	
	# Remove this card from the hand
	#level.hand.cards.erase(self)
	level.hand.removeCard(self)
	
	# Add this card to the discard deck
	level.discardDeck.addCard(self)
