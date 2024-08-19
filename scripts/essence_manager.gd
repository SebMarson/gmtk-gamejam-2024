extends RefCounted

class_name EssenceManager

var essences = {}

func _init() -> void:
	# Load essences
	addEssence(StrongEssence.new())
	addEssence(DarknessEssence.new())
	addEssence(FastEssence.new())
	addEssence(LightEssence.new())
	
	print("Essences loaded")
	
func addEssence(essence) -> void:
	essences[essence.name] = essence
	
func getEssence(essenceName) -> Essence:
	return essences[essenceName]

func getEssenceShader(essenceName) -> ShaderMaterial:
	assert(essences.get(essenceName) != null, "Invalid essence name supplied")
	return essences.get(essenceName).shader
