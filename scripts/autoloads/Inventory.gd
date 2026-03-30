extends Node

const MAX_STACK := 99

# Diccionario: item_id -> cantidad
var items: Dictionary = {}

signal item_added(item_id: String, amount: int)
signal item_removed(item_id: String, amount: int)
signal inventory_changed()

func add_item(item_id: String, amount: int = 1) -> void:
	items[item_id] = mini(get_amount(item_id) + amount, MAX_STACK)
	item_added.emit(item_id, amount)
	inventory_changed.emit()

func remove_item(item_id: String, amount: int = 1) -> bool:
	if not has_enough(item_id, amount):
		return false
	items[item_id] -= amount
	if items[item_id] <= 0:
		items.erase(item_id)
	item_removed.emit(item_id, amount)
	inventory_changed.emit()
	return true

func has_enough(item_id: String, amount: int) -> bool:
	return get_amount(item_id) >= amount

func get_amount(item_id: String) -> int:
	return items.get(item_id, 0)

func has_item(item_id: String) -> bool:
	return items.has(item_id) and items[item_id] > 0
