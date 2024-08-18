extends Control

var level
var cards = []

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setLevel(levelRef) -> void:
	level = levelRef


func _on_continue_button_pressed() -> void:
	for card in cards:
		$DeckSVBoxContainer/DeckSScrollContainer/DeckSGridContainer.remove_child(card)
		
	cards = []
		
	level.continueFights()
