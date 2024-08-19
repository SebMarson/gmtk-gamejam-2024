extends Control

var level
var cards = []
var DECK_SIZE

func setup(deckSize) -> void:
	DECK_SIZE = deckSize
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Created deck")
	custom_minimum_size = $DeckSprite.texture.get_size()
	setupDeck()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Deck clicked on")
			endTurn()
			
func setupDeck() -> void:
	print("DECK SIZE: " + str(DECK_SIZE))
	var cardScene : PackedScene = load("res://scenes/card.tscn")
	if (DECK_SIZE > 0):
		for n in DECK_SIZE:
			var damage = RandomNumberGenerator.new().randi_range(1, 5)
			var newCard = cardScene.instantiate()
			newCard.setPower(damage)
			newCard.setLevel(level)
			cards.append(newCard)
	$Label.text = str(cards.size())
	
func drawCard() -> Node:
	var card = getCardAtRandom()
	return card
		
func getCardAtRandom() -> Node:
	if cards.size() > 0:
		var card = cards[RandomNumberGenerator.new().randi_range(0, cards.size()-1)]
		cards.erase(card)
		$Label.text = str(cards.size())
		return card
	else:
		# Try and shuffle in discard deck if it has some cards in it
		if (level.discardDeck.cards.size() > 0):
			level.shuffleDiscard()
			return getCardAtRandom()
		else:
			return null
		
func addCard(card) -> void:
	cards.append(card)
	$Label.text = str(cards.size())
	
func addCards(newCards) -> void:
	cards.append_array(newCards)
	$Label.text = str(cards.size())
	
func removeCard(card) -> void:
	cards.erase(card)
	$Label.text = str(cards.size())
	
func removeAllCards() -> Array:
	var returnCards = cards
	cards = []
	$Label.text = str(cards.size())
	return returnCards

func setLevel(levelRef) -> void:
	level = levelRef
			
func endTurn() -> void:
	level.hand.draw()

func pruneSmallCards() -> void:
	for n in range(cards.size()-1, -1, -1):
		var card = cards[n]
		if (card.power < level.score/3):
			cards.erase(card)
