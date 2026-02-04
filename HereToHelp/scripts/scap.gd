extends Node2D

class_name Scap

# =================================
# Constants
# =================================
const MAX_HP := 10

# =========================
# Exported (editor-visible) parameters
# =========================

@export var speed: float = 120.0
@export var is_enabled: bool = true

# Editor-only grouping (nice for sanity)
@export_group("Tuning")
@export var acceleration: float = 600.0
@export var friction: float = 800.0

# =========================
# Public state
# =========================

var velocity: Vector2 = Vector2.ZERO
var humours: int = 0
var action: String = "waiting"





# =========================
# Private state (convention)
# =========================

var _target_position: Vector2

var _patients: Dictionary = {}

# =========================
# Lifecycle
# =========================

func _ready() -> void:
	_target_position = global_position


	

# =========================
# Public API
# =========================



func add_patient() -> bool:
	
	return true


# =========================
# Private helpers
# =========================
