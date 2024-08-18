extends RefCounted

class_name MonsterFactory

# Monster scene list:
# 0 - Tardigrade
# 1 - Dust mite
var monster_scenes = [load("res://scenes/monsters/tardigrade.tscn"),load("res://scenes/monsters/dust_mite.tscn")]

var rng = RandomNumberGenerator.new()

# Generates an appropriate monster given the current score
func generateMonster(score) -> Node:
	print("Monster generating")
	
	var monster = null
	if (score < 30):
		monster = monster_scenes[rng.randi_range(0, 1)].instantiate()
	return monster
