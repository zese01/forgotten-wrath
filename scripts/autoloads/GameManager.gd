extends Node

# Estado del mundo
var current_zone: String = "valley_of_gods"
var day_time: float = 0.0
var day_duration: float = 120.0

# Progresión
var fragments_collected: Array[String] = []
var memories_unlocked: Array[String] = []
var sanctuary_tier: int = 1

# Amenaza de Ascendidos (0-100)
var ascendant_threat: int = 0

# Raza del protagonista
var player_race: String = ""

func _ready() -> void:
	EventBus.fragment_collected.connect(_on_fragment_collected)
	EventBus.creature_created.connect(_on_creature_created)

func _process(delta: float) -> void:
	day_time = fmod(day_time + delta, day_duration)

func _on_fragment_collected(fragment_id: String) -> void:
	if fragment_id not in fragments_collected:
		fragments_collected.append(fragment_id)
	_check_sanctuary_tier()

func _on_creature_created(_creature_type: String) -> void:
	ascendant_threat = mini(ascendant_threat + 5, 100)
	EventBus.ascendant_threat_changed.emit(ascendant_threat)

func _check_sanctuary_tier() -> void:
	var count := fragments_collected.size()
	var new_tier := 1
	if count >= 1: new_tier = 2
	if count >= 3: new_tier = 3
	if count >= 7: new_tier = 4
	if new_tier != sanctuary_tier:
		sanctuary_tier = new_tier
		EventBus.sanctuary_tier_changed.emit(sanctuary_tier)

func get_day_phase() -> String:
	var t := day_time / day_duration
	if t < 0.25: return "night"
	if t < 0.5: return "morning"
	if t < 0.75: return "afternoon"
	return "dusk"
