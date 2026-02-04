extends Problem

class_name Symptom
	#symptoms may +/1 sanity_mod, humour_mod, right_mod
	#symtoms expire on apply if not treated
	
var treatments: Array[Treatment]

# child
func _init():
	type = "Symptom"

func get_stats() -> String:
	return "#" + type + "#" + name + "##" + "Sanity Mod: " + str(sanity_mod) + "Humour Mod: " + str(humour_mod) + "Right Mod: " + str(right_mod) + "Treatments: " + str(treatments)
