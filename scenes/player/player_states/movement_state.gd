extends RewindableState
class_name MovementState

@export var player_input: PlayerInput
@export var player_main: PlayerMain

func _rollback_tick(delta: float, _tick: int, _is_fresh: bool) -> void:
	if !netfox_player_is_on_floor():
		apply_gravity(delta)

func apply_gravity(delta: float) -> void:
	player_main.velocity += player_main.get_gravity() * player_main.current_weight * delta

func accelerate(vector: Vector2) -> void:
	var move_delta: float = (player_main.stop_speed * player_main.speed) / 100
	if vector:
		move_delta += player_main.acceleration
	player_main.velocity = player_main.velocity.move_toward(player_main.speed * vector, move_delta * player_main.friction)

func move_player(_delta: float) -> void:
	#placeholder_gravity(delta)
	player_main.velocity *= NetworkTime.physics_factor
	player_main.move_and_slide()
	player_main.velocity /= NetworkTime.physics_factor

# https://foxssake.github.io/netfox/latest/netfox/tutorials/rollback-caveats/
func netfox_player_is_on_floor() -> bool:
	var old_velocity: Vector2 = player_main.velocity
	player_main.velocity = Vector2.ZERO
	player_main.move_and_slide()
	player_main.velocity = old_velocity
	
	if player_main.is_on_floor():
		return true
	else:
		return false
