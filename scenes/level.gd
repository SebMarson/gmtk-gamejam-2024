extends Node2D

var handScene : PackedScene = load("res://scenes/hand.tscn")
var deckScene : PackedScene = load("res://scenes/deck.tscn")
var monsterScene : PackedScene = load("res://scenes/monster.tscn")
var deckScreenScene = load("res://scenes/deck_screen.tscn")
var mitosisScene = load("res://scenes/mitosis_screen.tscn")

# UI Elements
var hand
var drawDeck
var discardDeck
var deckScreen
var mitosisScreen

var europeFlag = false
var earthFlag = false

# Internal vars
var currentMonster
var score: float = 5

var monsterFactory = MonsterFactory.new()
var essenceManager = EssenceManager.new()

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize Draw Deck
	drawDeck = deckScene.instantiate()
	drawDeck.setup(15)
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
	
	# Initialize deck screen
	deckScreen = deckScreenScene.instantiate()
	deckScreen.setLevel(self)
	
	# Initialize mitosis screen
	mitosisScreen = mitosisScene.instantiate()
	mitosisScreen.setLevel(self)
	mitosisScreen.position = Vector2(600, 100)
	mitosisScreen.size = Vector2(900, 500)
	
	# Setup score board
	setSizeValue()
	
	# Load monster
	spawnMonster()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var threshold: float = 20
	if (score > 40 and score < 80):
		threshold = 40
	elif (score > 80 and score < 100):
		threshold = 80
	else:
		threshold = 100
	var scaleFactor = threshold/float(self.score)
	$Background.scale = Vector2(scaleFactor, scaleFactor)

func spawnMonster() -> void:
	#currentMonster = monsterScene.instantiate()
	#currentMonster.position = Vector2((1280/2), 100)
	if (score < 70):
		currentMonster = monsterFactory.generateMonster(score)
	elif (!europeFlag):
		currentMonster = monsterFactory.generateEurope()
	elif (!earthFlag):
		currentMonster = monsterFactory.generateEarth()
	else:
		currentMonster = monsterFactory.generateSun()
		
	currentMonster.position = Vector2((1280/2), 100)
	currentMonster.setLevel(self)
	add_child(currentMonster)
	
func shuffleDiscard() -> void:
	drawDeck.addCards(discardDeck.removeAllCards())

func addScore(newScore) -> void:
	score += newScore
	if (score > 0 and score < 20):
		$Background.texture = load("res://graphics/backgrounds/tiny-background.png")
	elif (score >= 20 and score < 50):
		$Background.texture = load("res://graphics/backgrounds/outside-background.png")
	elif (score >= 50 and score < 70):
		$Background.texture = load("res://graphics/backgrounds/orbit-background.png")
	else:
		$Background.texture = load("res://graphics/backgrounds/space-background.png")
	
func decreaseScore(newScore) -> void:
	score -= newScore
	setSizeValue()
	
func setSizeValue() -> void:
	$ScoreContainer/ScoreValue.text = str(score)

func postUserGo() -> void:
	if currentMonster != null:
		# Monster alive, continue fight
		currentMonster.attack()
	else:
		# Discard hand into the discard deckz
		hand.discardHand()
		
		# The monster is dead, shuffle cards back into draw deck
		shuffleDiscard()
		
		# Remove cards that are too small
		drawDeck.pruneSmallCards()
		
		# Go to next screen
		goToDeckScreen()
		
func goToDeckScreen() -> void:
		# Show deck screen
		remove_child(hand)
		remove_child(drawDeck)
		remove_child(discardDeck)
		add_child(deckScreen)
		deckScreen.loadCards()
		
func goToMitosisScreen(originalCard, newCards) -> void:
		# Show deck screen
		remove_child(hand)
		remove_child(drawDeck)
		remove_child(discardDeck)
		remove_child(deckScreen)
		add_child(mitosisScreen)
		mitosisScreen.loadCards(originalCard, newCards)

func continueFights() -> void:
		# Hide deck screen
		add_child(hand)
		add_child(drawDeck)
		add_child(discardDeck)
		remove_child(deckScreen)
		remove_child(mitosisScreen)
		
		spawnMonster()
		hand.draw()
	
