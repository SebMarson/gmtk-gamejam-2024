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
			card.drawn()
			addCardToHand(card)
		else:
			print("No more cards in the deck!!")
		
func discardHand() -> void:
	print("Discarding hand")
	# while there are cards in your hand, discard them
	while (cards.size() > 0):
		var card = cards[0]
		card.discard()
		
	# Clear cards array
	cards = []
	
func addCardToHand(card) -> void:
	cards.append(card)
	$HandHBoxContainer.add_child(card)

func removeCardFromHand(card) -> void:
	cards.erase(card)
	$HandHBoxContainer.remove_child(card)
