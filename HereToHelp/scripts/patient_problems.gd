extends Node2D
class_name Problem
var type = "Problem"
var problem_name = "test"
var description = "This is a test description"
var disabled = false

var patient: Patient

var sanity_mod: int = 0
var humour_mod: int = 0
var right_mod: int = 0

var ttl: int = 1



func apply() -> bool:
	return self._apply()

func get_stats() -> String:
	return "#" + type + "#" + name + "##" + "Sanity Mod: " + str(sanity_mod) + "Humour Mod: " + str(humour_mod) + "Right Mod: " + str(right_mod)
	
func _apply() -> bool:
	ttl -= 1
	return true
	
func _expire() -> bool:
	disabled=true
	return true	
	


		
	



		
		
