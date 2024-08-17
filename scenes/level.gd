extends Node2D

var handScene : PackedScene = load("res://scenes/hand.tscn")
var deckScene : PackedScene = load("res://scenes/deck.tscn")
var monsterScene : PackedScene = load("res://scenes/monster.tscn")

var hand
var drawDeck
var discardDeck
var currentMonster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize Draw Deck
	drawDeck = deckScene.instantiate()
	drawDeck.setup(25)
	drawDeck.setLevel(self)
	drawDeck.position = Vector2(1100, 500)
	add_child(drawDeck)
	
	# Initialize Discard Deck
	discardDeck = deckScene.instantiate()
	discardDeck.setup(0)
	discardDeck.setLevel(self)
	discardDeck.position = Vector2(100, 500)
	add_child(discardDeck)
	
	# Initialize Hand
	hand = handScene.instantiate()
	hand.setLevel(self)
	hand.draw()
	add_child(hand)
	
	# Load monster
	spawnMonster()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnMonster() -> void:
	currentMonster = monsterScene.instantiate()
	currentMonster.position = Vector2((1280/2), 100)
	currentMonster.setLevel(self)
	add_child(currentMonster)
	
func shuffleDiscard() -> void:
	drawDeck.addCards(discardDeck.removeAllCards())

func addScore(score) -> void:
	$ScoreContainer/ScoreValue.text = str(int($ScoreContainer/ScoreValue.text) + score)
	
func decreaseScore(score) -> void:
	$ScoreContainer/ScoreValue.text = str(int($ScoreContainer/ScoreValue.text) + score)

func postUserGo() -> void:
	currentMonster.attack()
