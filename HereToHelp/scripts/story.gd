extends Problem

class_name Story
	#stories can add any amount of maladies, treatments, or symptoms.
	#triggered on day provided
var chapter_name = "Chapter 0"
var story_text = "In the beginning, there were no problems."
#var triggers = []

var day_triggered = 0

var maladies = []
var treatments = []
var symptoms = []

var dialogue_tree = {}

# child
func _init():
	type = "Story"
	ttl = 1
