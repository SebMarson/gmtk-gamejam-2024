extends RefCounted

class_name MonsterFactory

# Monster scene list:
# 0 - Tardigrade
# 1 - Dust mite
# 2 - Ant
# 3 - Worm
# 4 - Cat
var monster_scenes = ["tardigrade","dust_mite","ant","worm","cat"]

var rng = RandomNumberGenerator.new()

# Generates an appropriate monster given the current score
func generateMonster(score) -> Node:
	print("Monster generating")
	
	var monster = null
	if (score < 30):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(0, 1)] + ".tscn").instantiate()
	elif (score < 40):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(2, 3)] + ".tscn").instantiate()
	elif (score < 50):
		monster = load("res://scenes/monsters/" + monster_scenes[rng.randi_range(4, 4)] + ".tscn").instantiate()
	return monster
