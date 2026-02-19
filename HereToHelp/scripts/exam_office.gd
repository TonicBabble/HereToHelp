extends Node2D
class_name HereToHelp

@export var scap_scene: PackedScene

@export var patient_scene: PackedScene

@export var problems_scene: PackedScene
@export var symptom_scene: PackedScene
@export var treatment_scene: PackedScene
@export var malady_scene: PackedScene
@export var story_scene: PackedScene
@export var diagnostic_scene: PackedScene

@onready var treatment_menu: MenuButton = $TreatmentsMenu
@onready var treatment_popup: PopupMenu = treatment_menu.get_popup()

@onready var diagnostic_menu: MenuButton = $DiagnosticsMenu
@onready var diagnostic_popup: PopupMenu = diagnostic_menu.get_popup()

@onready var debug_label: RichTextLabel = $Debug

@onready var histSanity: Line2D = $histSanity
@onready var histHumour: Line2D = $histHumour
@onready var histRight: Line2D = $histRight

var symptoms: Array[Symptom] = []
var maladies: Array[Malady] = []
var treatments: Array[Treatment] = []
var stories: Array[Story] = []
var diagnostics: Array[Diagnostic] = []

var current_patient: Patient

var turn: int = 0

var chartMinX: float = 333
var chartMinY: float = 22

var chartMaxX: float = 340
var chartMaxY: float = 27

func _ready() -> void:
	
	var scap := scap_scene.instantiate() as Scap
	add_child(scap)
	
	var patient1 := patient_scene.instantiate() as Patient
	add_child(patient1)
	current_patient = patient1
	patient1.name = "Terry Blathe"
	patient1.description = "Terry Blathe | Man-About-Town | Connected "
	
	
	
	buildTreatmentsList()
	print("Treatments made! : ", str(treatments.size()))
	buildSymptomsList()
	print("Symptoms made! : ", str(symptoms.size()))
	buildMaladiesList()
	print("maladies made! : ", str(maladies.size()))
	buildStoriesList()
	print("stories made! : ", str(stories.size()))
	buildDiagnosticList()
	print("diagnostics made! : ", str(diagnostics.size()))
	
	#patient1.add_problem(stories[randi() % stories.size()])
	

	
	patient1._progress_turn(1)

func buildTreatmentsList() -> void:
	var elements:Array[String] = ["Sanity", "Humours", "Right"]
	var id:int = 0
	for element in elements:
		for i in [1,2]:
			id += 1
			var new_treatment = treatment_scene.instantiate() as Treatment
			new_treatment.name = "treatment " + str(id)
			new_treatment.description = "Cursed cursed treatment! " + str(id)
			new_treatment.ttl = 1
			match element:
				"Sanity": new_treatment.sanity_mod = 1
				"Humours": new_treatment.humour_mod = 1
				"Right": new_treatment.right_mod = 1
			treatments.append(new_treatment) 
			treatment_popup.add_item(new_treatment.name)
			treatment_popup.id_pressed.connect(_on_treatment_item_pressed)

	

func buildSymptomsList() -> void:
	var elements:Array[String] = ["Sanity", "Humours", "Right"]
	var id:int = 0
	for element in elements:
		for i in [1,2]:
			id += 1
			var new_symptom = symptom_scene.instantiate() as Symptom
			new_symptom.name = "symptom " + str(id)
			new_symptom.description = "Cursed cursed symptom! " + str(id)
			new_symptom.ttl = 1
			new_symptom.treatments.append(treatments[randi() % treatments.size()])
			match element:
				"Sanity":
					new_symptom.sanity_mod = i
				"Humours":
					new_symptom.humour_mod = i
				"Right":
					new_symptom.right_mod = i
			symptoms.append(new_symptom)
			
			id += 1
			var new_complex_symptom = symptom_scene.instantiate() as Symptom
			new_complex_symptom.name = "complex symptom " + str(id)
			new_complex_symptom.description = "Complex Cursed cursed symptom! " +  str(id)
			new_complex_symptom.ttl = 1
			new_complex_symptom.treatments.append(treatments[randi() % treatments.size()])
			match element:
				"Sanity":
					new_complex_symptom.sanity_mod = 1
					match i:
						1: new_complex_symptom.humour_mod = 1
						2: new_complex_symptom.right_mod = 1
				"Humours":
					new_complex_symptom.humour_mod = 1
					match i:
						1: new_complex_symptom.sanity_mod = 1
						2: new_complex_symptom.right_mod = 1
				"Right":
					new_complex_symptom.right_mod = 1
					match i:
						1: new_complex_symptom.sanity_mod = 1
						2: new_complex_symptom.right_mod = 1
			symptoms.append(new_complex_symptom)
		


func buildMaladiesList() -> void:
	var elements:Array[String] = ["Sanity", "Humours", "Right"]
	var id:int = 0
	for element in elements:
		for i in [1,2]:
			id += 1
			var new_malady = malady_scene.instantiate() as Malady
			new_malady.name = "malady " + str(id)
			new_malady.description = "Cursed cursed malady! " + str(id)
			new_malady.symptoms.append(symptoms[randi() % symptoms.size()])
			new_malady.symptoms.append(symptoms[randi() % symptoms.size()])
			new_malady.treatments.append(treatments[randi() % treatments.size()])
			match element:
				"Sanity": new_malady.sanity_mod = 1
				"Humours": new_malady.humour_mod = 1
				"Right": new_malady.right_mod = 1
			maladies.append(new_malady) 
			
func buildStoriesList() -> void:
	var elements:Array[String] = ["Sanity", "Humours", "Right"]
	var id:int = 0
	for element in elements:
		for i in [1,2]:
			id += 1
			var new_story = story_scene.instantiate() as Story
			new_story.name = "Cursed Story " + str(id)
			new_story.day_triggered = id
			new_story.maladies.append(maladies[randi() % maladies.size()])
			new_story.maladies.append(maladies[randi() % maladies.size()])
			stories.append(new_story)
			
func buildDiagnosticList() -> void:
	var elements:Array[String] = ["Sanity", "Humours", "Right"]
	var id: int = 0
	for element in elements:
		for i in [1,2,3]:
			id += 1
			var new_diagnostic = diagnostic_scene.instantiate() as Diagnostic
			new_diagnostic.name = "Cursed diagnostic " + str(id)
			new_diagnostic.symptoms.append(symptoms[randi() % symptoms.size()])
			new_diagnostic.freq = 4-i
			new_diagnostic.ttl = 12
			match element:
				"Sanity": new_diagnostic.sanity_mod = i
				"Humours": new_diagnostic.humour_mod = i
				"Right": new_diagnostic.right_mod = i
				
					
			new_diagnostic.measures = [element]
			diagnostics.append(new_diagnostic)
			diagnostic_popup.add_item(new_diagnostic.name)
			diagnostic_popup.id_pressed.connect(_on_diagnostic_item_pressed)

func _on_next_turn_pressed() -> void:
	current_patient._progress_turn(1)
	turn += 1

	
	_build_histograms()
	
	var stats = current_patient._problems.map(func(p):
		return p.get_stats()
	)
	debug_label.text = "\n".join(stats)
	
	
	pass # Replace with function body.

func _on_treatment_item_pressed(index: int):
	var selection = treatment_popup.get_item_text(index)
	var treat = treatments.filter(func(p):
		return p.name == selection
	)
	if treat:
		current_patient.add_problem(treat[0])
		
func _on_diagnostic_item_pressed(index: int):
	var selection = diagnostic_popup.get_item_text(index)
	var diag = diagnostics.filter(func(p):
		return p.name == selection
	)
	if diag:
		current_patient.add_problem(diag[0])
		
func _build_histograms():
	histSanity.clear_points()
	histHumour.clear_points()
	histRight.clear_points()
	
	if current_patient._diagnosis_history.size()>0:
		var step = 0
		var usable_history = current_patient._diagnosis_history.slice(-21,-1)
		
		for diag in usable_history:
			if step < 20:
				step += 1
			for key in diag.keys():
				if key != "turn":
					var x:float = chartMinX + (step*10) 
					var y:float = 0
					y = chartMinY + diag[key]/10.00
					match key:
						"Sanity": 
							histSanity.add_point(Vector2(x,y))
						"Humour": 
							histHumour.add_point(Vector2(x,y+20))
						"Right": 
							histRight.add_point(Vector2(x,y+40))
							
						
					
