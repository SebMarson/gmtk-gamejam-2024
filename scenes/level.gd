extends Node2D

var handScene : PackedScene = load("res://scenes/hand.tscn")
var deckScene : PackedScene = load("res://scenes/deck.tscn")
var monsterScene : PackedScene = load("res://scenes/monster.tscn")
var deckScreenScene = load("res://scenes/deck_screen.tscn")

var shaders = {}

# UI Elements
var hand
var drawDeck
var discardDeck
var deckScreen

var currentMonster

var monsterFactory = MonsterFactory.new()

func _init() -> void:
	pass

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
	
	# Initialize deck screen
	deckScreen = deckScreenScene.instantiate()
	deckScreen.setLevel(self)
	deckScreen.position = Vector2(200, 100)
	deckScreen.size = Vector2(900, 500)
	
	loadShaders()
	
	# Load monster
	spawnMonster()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func loadShaders() -> void:
	loadShader("STRONG", "res://shaders/strong.gdshader")
	loadShader("DARKNESS", "res://shaders/darkness.gdshader")
	
func loadShader(name, path) -> void:
	var shader_code: Shader = load(path)
	var shader = ShaderMaterial.new()
	shader.shader = shader_code
	shaders[name] = shader

func spawnMonster() -> void:
	#currentMonster = monsterScene.instantiate()
	#currentMonster.position = Vector2((1280/2), 100)
	currentMonster = monsterFactory.generateMonster(int($ScoreContainer/ScoreValue.text))
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
	if currentMonster != null:
		# Monster alive, continue fight
		currentMonster.attack()
	else:
		# Discard hand into the discard deckz
		hand.discardHand()
		
		# The monster is dead, shuffle cards back into draw deck
		shuffleDiscard()
		
		# Show deck screen
		remove_child(hand)
		remove_child(drawDeck)
		remove_child(discardDeck)
		add_child(deckScreen)
		deckScreen.loadCards()

func continueFights() -> void:
		# Hide deck screen
		add_child(hand)
		add_child(drawDeck)
		add_child(discardDeck)
		remove_child(deckScreen)
		
		spawnMonster()
		hand.draw()
	
