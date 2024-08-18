extends Control

var level
var cards = []
var selectedCards = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set size of scroll container to fill this control node
	$DeckSVBoxContainer.size = size	
	$DeckSVBoxContainer/DeckSScrollContainer.custom_minimum_size = size	
	
	# Set grid container padding margins
	$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.add_theme_constant_override("h_separation", 10)
	$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.add_theme_constant_override("v_separation", 10)
	
	
func loadCards() -> void:
	# Load cards from deck
	cards = level.drawDeck.cards
	for card in cards:
		$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.add_child(card)
		
		
func cardClicked(card) -> void:
	if (selectedCards.has(card)):
		print("Unselected card")
		card.get_node("SelectedSprite").visible = false
		selectedCards.erase(card)
	elif(selectedCards.size() == 0):
		print("Selected card")
		card.get_node("SelectedSprite").visible = true
		selectedCards.append(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func setLevel(levelRef) -> void:
	level = levelRef


func _on_continue_button_pressed() -> void:
	backToLevel()
	

func backToLevel() -> void:
	for card in cards:
		$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.remove_child(card)
		
	cards = []
		
	level.continueFights()


func toMitosis(originalCard, newCards) -> void:
	for card in cards:
		$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.remove_child(card)
		
	cards = []
		
	level.goToMitosisScreen(originalCard, newCards)


func _on_mitosis_button_pressed() -> void:
	print("Mitosis selected")
	if selectedCards.size() > 0:
		var cardScene : PackedScene = load("res://scenes/card.tscn")
		
		var originalCard = null
		var newCards = []
		for card in selectedCards:
			var damage = card.power/2
			
			var newCardOne = cardScene.instantiate()
			newCardOne.setPower(damage)
			newCardOne.setLevel(level)
			newCards.append(newCardOne)
			
			var newCardTwo = cardScene.instantiate()
			newCardTwo.setPower(damage)
			newCardTwo.setLevel(level)
			newCards.append(newCardTwo)
			
			if (card.essence != null):
				card.essence.executeCardMitosis(level, card, newCards)
				
			# Add cards to deck
			for newCard in newCards:
				level.drawDeck.addCard(newCard)
				
			originalCard = card
				
		# Remove old cards from deck
		while (selectedCards.size() > 0):
			var selectedCard = selectedCards[0]
			level.drawDeck.removeCard(selectedCard)
			selectedCards.erase(selectedCard)
		
		$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.remove_child(originalCard)
		originalCard.get_node("SelectedSprite").visible = false
		toMitosis(originalCard, newCards)
