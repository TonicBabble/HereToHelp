extends Problem

class_name Diagnostic

# diagnostics are problems that cause symptoms, but are also the only way to 
# to obtain information

# this diagnostic has a set of symptoms it causes
var symptoms = []
var measures = []
# happens daily
var freq: int = 1
# this represents a state of the patients sanity, humour, and right by turn.
var diagnosis = {}

var turn: int = 0 

var elements:Array[String] = ["Sanity", "Humours", "Right"]


func get_diagnosis() -> Dictionary:
	return diagnosis

func _apply() -> bool:
	
	
				
	
	return true



# child
func _init():
	type = "Diagnostic"
	
	
