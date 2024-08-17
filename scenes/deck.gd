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
func _process(delta: float) -> void:
	pass

func _gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Deck clicked on")
			endTurn()
			
func setupDeck() -> void:
	print("DECK SIZE: " + str(DECK_SIZE))
	if (DECK_SIZE > 0):
		for n in DECK_SIZE:
			var cardScene : PackedScene = load("res://scenes/card.tscn")
			cards.append(cardScene.instantiate())
	$Label.text = str(cards.size())
		
func getCardAtRandom() -> Node:
	if cards.size() > 0:
		var card = cards[RandomNumberGenerator.new().randi_range(0, cards.size()-1)]
		cards.erase(card)
		$Label.text = str(cards.size())
		return card
	else:
		level.shuffleDiscard()
		return getCardAtRandom()
		
func addCard(card) -> void:
	cards.append(card)
	$Label.text = str(cards.size())
	
func addCards(newCards) -> void:
	cards.append_array(newCards)
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
