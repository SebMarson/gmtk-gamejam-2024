extends RefCounted

class_name MonsterFactory

# Monster scene list:
# 0 - Tardigrade
# 1 - Dust_mite
# 2 - Ant
# 3 - Worm
# 4 - Cat
# 5 - Bird
# 6 - House
# 7 - Truck
# 8 - Cyclotron
# 9 - Motorway_network
# 10 - Europe
# 11 - Earth
# 12 - Sun
var monster_scenes = ["tardigrade","dust_mite","ant","worm","cat","bird","house","truck","cyclotron","motorway_network","europe","earth","sun"]

var rng = RandomNumberGenerator.new()

# Generates an appropriate monster given the current score
func generateMonster(score) -> Node:
	print("Monster generating")
	
	var monster = null
	if (score < 15):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(0, 1)] + ".tscn").instantiate()
	elif (score < 20):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(2, 3)] + ".tscn").instantiate()
	elif (score < 30):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(4, 5)] + ".tscn").instantiate()
	elif (score < 50):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(6, 7)] + ".tscn").instantiate()
	elif (score < 70):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(8, 9)] + ".tscn").instantiate()
	return monster

func generateEurope() -> Node:
	return load("res://scenes/monsters/europe.tscn").instantiate()

func generateEarth() -> Node:
	return load("res://scenes/monsters/earth.tscn").instantiate()

func generateSun() -> Node:
	return load("res://scenes/monsters/sun.tscn").instantiate()
