extends Control

var level
var power: int
var effect: Essence
var essence: Essence

# Set to true if the card is in the hand, in play, set to false if it's in the deck
var inPlay: bool

# Set to 0 if it's not currently selected, set to 1 if it has been selected
var selected: bool

func _init() -> void:
	print("Created a card")
	inPlay = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = $CardSprite.texture.get_size()
	$Label.text = str(power)
	selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			play_card()

func setLevel(levelRef) -> void:
	level = levelRef
	
func setPower(power) -> void:
	self.power = power
	
func defeatedMonster(monster) -> void:
	setEssence(monster.essence)
	increasePower(monster.SCORE)
	
func setEssence(essence: Essence) -> void:
	print("Card essence set to " + essence.name)
	self.essence = essence
	
	# Update shader
	$CardSprite.material = essence.shader
	print("Card sprite material updated")
	
func increasePower(amount) -> void:
	print("Card power increased by " + str(amount))
	power += amount
	$Label.text = str(power)
	
# Called when this card is drawn
func drawn() -> void:
	print("Card drawn")
	var scaleFactor = float(power)/float(level.score)
	if scaleFactor < 1:
		scaleFactor = max(0.5, scaleFactor)
	else:
		scaleFactor = min(1.5, scaleFactor)
	$CardSprite.scale = Vector2(scaleFactor, scaleFactor)
	
	# Mark self as in play
	inPlay = true
	
# Called when this card is discarded during play
func discard() -> void:
	print("Card discarded")
	# Scale back to normal
	$CardSprite.scale = Vector2(1, 1)
	
	# Mark self as no longer in play
	inPlay = false
	
	# Remove self from hand
	level.hand.removeCardFromHand(self)
	
	# Add self to discard deck
	level.discardDeck.addCard(self)


func play_card() -> void:
	print("Card clicked on")
	if (inPlay):
		# Do effects
		if (essence != null):
			essence.executeCardPlayed(level, level.currentMonster, self)
		else:
			print("No effect on card")
			
		# Deal base damage to monster
		if (power > 0) and (level.currentMonster != null):
			level.currentMonster.dealDamage(self, power)
		
		# Discard
		discard()
		
		# Prompt level to do its post user-go stuff
		level.postUserGo()
	else:
		print("Mitosis")
