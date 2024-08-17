extends Node2D

var cards = []
var level
var MAX_HAND_SIZE = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	position = Vector2((1280/2), 550)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setLevel(levelRef) -> void:
	level = levelRef

func draw() -> void:
	var cardScene : PackedScene = load("res://scenes/card.tscn")
	for n in (MAX_HAND_SIZE - cards.size()):
		var card = level.drawDeck.getCardAtRandom()
		if card != null:
			cards.append(card)
		else:
			print("No more cards in the deck!!")
	
	for card in cards:
		card.setLevel(level)
		$HBoxContainer.add_child(card)

func removeCard(card) -> void:
	cards.erase(card)
	$HBoxContainer.remove_child(card)
