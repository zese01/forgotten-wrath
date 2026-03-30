extends Node

# Combate
signal enemy_died(enemy_type: String, position: Vector3)
signal player_damaged(amount: float, source: String)
signal player_died()

# Fragmentos y memoria
signal fragment_collected(fragment_id: String)
signal memory_unlocked(memory_id: String)

# Criaturas
signal creature_created(creature_type: String)
signal creature_corrupted(creature_id: String)
signal creature_destroyed(creature_id: String)

# Ascendidos
signal ascendant_threat_changed(new_level: int)

# Base
signal sanctuary_tier_changed(new_tier: int)
signal npc_arrived_at_base(npc_id: String)

# Zonas
signal zone_unlocked(zone_id: String)
signal zone_changed(from_zone: String, to_zone: String)
