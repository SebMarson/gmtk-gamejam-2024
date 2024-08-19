extends Control

var level
var originalCard
var newCards

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _gui_input(event) -> void:
	if (event is InputEventMouseButton) or (event is InputEventKey):
		print("Interrupt mitosis screen")
		$Timer.stop()
		_on_timer_timeout()
	
func setLevel(level) -> void:
	self.level = level
	
func loadCards(originalCard, newCards) -> void:
	self.originalCard = originalCard
	self.newCards = newCards
	$HBoxContainer.custom_minimum_size = originalCard.size
	$HBoxContainer/OriginalCardHolder.custom_minimum_size = originalCard.size
	$HBoxContainer/OriginalCardHolder.add_child(originalCard)
	
	for newCard in newCards:
		$NewCardHolder.add_child(newCard)
		
	$Timer.start(3)


func _on_timer_timeout() -> void:
	# Remove original card
	$HBoxContainer/OriginalCardHolder.remove_child(originalCard)
	
	# remove new cards
	for child in newCards:
		$NewCardHolder.remove_child(child)
		
	originalCard = null
	newCards = null
	level.continueFights()
