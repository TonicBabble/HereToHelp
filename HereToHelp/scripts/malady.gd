extends Problem

class_name Malady
#maladies may +/1 sanity_mod, humour_mod, right_mod
# maladies may cause symptoms
# maladies do not expire from time counting down
# maladies are "cured"

var symptoms = []

var treatments = []

# child
func _init():
	type = "Malady"
	ttl = 99999

func get_stats() -> String:
	var tl = ", ".join(treatments.map(func(p):return p.name))
	var sl = ", ".join(symptoms.map(func(p):return p.name))
	return "#" + type + "#" + name + "##" + "Sanity Mod: " + str(sanity_mod) + "Humour Mod: " + str(humour_mod) + "Right Mod: " + str(right_mod) + "Treatments: " + tl + "Symptoms: " + sl
