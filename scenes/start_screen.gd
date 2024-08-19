extends Node2D

var music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music = $Adventure
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	music.stop()
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_help_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/help_screen.tscn")


func _on_adventure_finished() -> void:
	music.play()
