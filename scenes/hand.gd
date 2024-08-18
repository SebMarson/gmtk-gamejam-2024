extends Node2D

var cards = []
var level
var MAX_HAND_SIZE = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	position = Vector2((1280/2), 550)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setLevel(levelRef) -> void:
	level = levelRef

func draw() -> void:
	for n in (MAX_HAND_SIZE - cards.size()):
		var card = level.drawDeck.drawCard()
		if card != null:
			cards.append(card)
		else:
			print("No more cards in the deck!!")
	
	for card in cards:
		card.setLevel(level)
		$HandHBoxContainer.add_child(card)
		
func discardHand() -> void:
	# REMEMBER THIS IS ARRAY NOT ARRAYLIST, ITERATING AND REMOVING IS BAD
	for card in cards:
		# Remove this card from the hand on screen
		$HandHBoxContainer.remove_child(card)
		
		# Add this card to the discard deck
		level.discardDeck.addCard(card)
		
		# Mark self as no longer in play
		card.inPlay = false
		
	# Clear cards array
	cards = []

func removeCard(card) -> void:
	cards.erase(card)
	$HandHBoxContainer.remove_child(card)
