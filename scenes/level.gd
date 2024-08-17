extends Node2D

var handScene : PackedScene = load("res://scenes/hand.tscn")
var deckScene : PackedScene = load("res://scenes/deck.tscn")
var monsterScene : PackedScene = load("res://scenes/monster.tscn")

var shaders = {}

var hand
var drawDeck
var discardDeck
var currentMonster

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
	
	loadShaders()
	
	# Load monster
	spawnMonster()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func loadShaders() -> void:
	var strong_shader_code: Shader = load("res://shaders/strong.gdshader")
	var strong_shader = ShaderMaterial.new()
	strong_shader.shader = strong_shader_code
	shaders["STRONG"] = strong_shader

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
	if currentMonster != null:
		# Monster alive, continue fight
		currentMonster.attack()
	else:
		# The monster is dead, shuffle cards back into draw deck
		shuffleDiscard()
		
		# Show deck screen
		# get_tree().change_scene_to_file("res://scenes/deck_screen.tscn")
		
		spawnMonster()
