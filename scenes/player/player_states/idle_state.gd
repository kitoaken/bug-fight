extends MovementState

func tick(delta: float, _tick: int, _is_fresh: bool) -> void:
	if netfox_player_is_on_floor():
		var move_vector: Vector2 = Vector2(player_input.input_vector.x, 0)
		accelerate(move_vector)
	
	move_player(delta)
	
	if netfox_player_is_on_floor():
		pass
