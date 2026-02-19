extends Node2D

class_name Scap

# =================================
# Constants
# =================================
const MAX_HP := 10

# =========================
# Exported (editor-visible) parameters
# =========================


@export var is_enabled: bool = true



# =========================
# Public state
# =========================

var humours: int = 0
var action: String = "waiting"





# =========================
# Private state (convention)
# =========================

var _target_position: Vector2



# =========================
# Lifecycle
# =========================

func _ready() -> void:
	_target_position = global_position


	

# =========================
# Public API
# =========================

#func detect_symptom() -> bool:
	

func add_patient() -> bool:
	
	return true


# =========================
# Private helpers
# =========================
