extends Node2D

class_name Patient

# =================================
# Constants
# =================================
const MAX_HP := 10

# =========================
# Exported (editor-visible) parameters
# =========================


@export var is_enabled: bool = true
@export var given_name: String = "Jon Doe" 
@export var description: String = "Lost to time, given a name. Jon Doe doesn't need what you take, because they don't know what they were given."
@export var health: int = 10

@onready var lblSanity: Label = $patient1/sanity_num
@onready var lblHumour: Label = $patient1/humour_num
@onready var lblRight: Label = $patient1/right_num

# =========================
# Public state
# =========================




var treatments: Array[Treatment]
var symptoms: Array[Symptom]
var maladies: Array[Malady]
var stories: Array[Story]
var diagnostics: Array[Diagnostic]

var sanity: int = 10
var humour: int = 10
var right: int = 10

var turn: int = 0

var visit_freq = 1



# =========================
# Private state (convention)
# =========================

#problems is an ordered list. 
var _problems = []
var _diagnosis_history: Array[Dictionary]



# =========================
# Lifecycle
# =========================

func _ready() -> void:
	print("patient ready")



# =========================
# Public API
# =========================


func add_patient() -> bool:
	return true

func add_problem(problem: Problem) -> bool:
	return self._add_problem(problem)
	

# =========================
# Private helpers
# =========================

func _apply_problem(problem: Problem) -> bool:
	problem.apply()
	sanity += problem.sanity_mod
	lblSanity.text = str(sanity)
	humour += problem.humour_mod
	lblHumour.text = str(humour)
	right += problem.right_mod
	lblRight.text = str(right)
	
	return true

func _flatten_problems() -> bool:
	_problems = _problems.filter(func(p):
		return p.ttl >= 1
	)
	
		
	stories = []
	symptoms = []
	maladies = []
	treatments = []
	diagnostics = []
	
	if _problems.size()>0:
		
		for problem in _problems:
			match problem.type:
				"Story": 
					if !stories.has(problem as Story):
						stories.append(problem as Story)
				"Symptom": 
					# symptoms don't stack
					if !symptoms.has(problem as Symptom):
						symptoms.append(problem as Symptom)
				"Malady": 
					# maladies don't stack
					if !maladies.has(problem as Malady):
						maladies.append(problem as Malady)
				"Treatment": 
					if !treatments.has(problem as Treatment):
						treatments.append(problem as Treatment)
				"Diagnostic":
					if !diagnostics.has(problem as Diagnostic):
						diagnostics.append(problem as Diagnostic)

		print("1 stories:" + str(stories.size()) + " symptoms:" + str(symptoms.size()) + " maladies:"+ str(maladies.size()) + " treatments:" + str(treatments.size())+ " diagnostics:" + str(treatments.size()))  

		for diagnostic in diagnostics:
			for symptom in diagnostic.symptoms:
				self.add_problem(symptom)
				
		
		for story in stories:
			for symptom in story.symptoms:
				self._add_problem(symptom)
			for malady in story.maladies:
				self._add_problem(malady)	
			for treatment in story.treatments:
				self._add_problem(treatment)
				
		
		
		for symptom in symptoms:
			
			for treatment in treatments:
				if symptom.treatments.has(treatment):
					_problems.erase(symptom)
					
		for malady in maladies:
			var treatment_found = false
			for treatment in treatments:
				if malady.treatments.has(treatment):
					treatment_found=true
			if	treatment_found:
				_problems.erase(malady)
			else:
				for symptom in malady.symptoms:	
					self._add_problem(symptom)

		print("stories:" + str(stories.size()) + " symptoms:" + str(symptoms.size()) + " maladies:"+ str(maladies.size()) + " treatments:" + str(treatments.size())+ " diagnostics:" + str(treatments.size()))  
		## _problems needs to sort with the other arrays in a predicatable order (story -> treatments -> symptoms -> malady )
	
		
	return true

func _add_problem(problem: Problem) -> bool:
	_problems.append(problem)
	return true

func _add_problems(problems: Array[Problem] ) -> bool:
	for problem in problems:
		_add_problem(problem)
	return true


func _record_diagnostics() -> bool:
	
	var sanityCaptured: bool = false
	var humourCaptured: bool = false
	var rightCaptured: bool = false
	
	var results = []
	for diagnostic in diagnostics:
		print(turn, diagnostic.name, diagnostic.measures)
		var diag_result = {}
		print(diagnostic.freq, diagnostic.measures.size())
		if (turn % diagnostic.freq == 0 && diagnostic.measures.size()>0):
			diag_result["turn"] = turn
			for measure in diagnostic.measures:
				match measure:
					"Sanity": 
						if !sanityCaptured:
							diag_result["Sanity"] = sanity
							sanityCaptured = true
					"Humour": 
						if !humourCaptured:
							diag_result["Humour"] = humour
							humourCaptured = true
					"Right": 
						if !rightCaptured:
							diag_result["Right"] = right
							rightCaptured = true
			if diag_result.keys().size()>1:
				results.append(diag_result)
	if results.size()>0:
		for result in results:
			_diagnosis_history.append(result)			
			if _diagnosis_history.size() > 100:
				_diagnosis_history.pop_front()
		
	return true	
	

func _progress_turn(turns: int) -> void:
	while(turns>0):
		turns -= 1
		turn += 1
		
		#story affects
		_flatten_problems()
		_record_diagnostics()
		_problems.map(self._apply_problem)
		
		#treatment affects
		#symptom affects
		#maladies affects
