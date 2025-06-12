extends BaseNetInput
class_name PlayerInput

# Internal variables to the player input. These aren't sent to the character
# controller, they only influence the variables below this section
var _joypad_input: bool = false
var _sprint_toggle: bool = false
var _flick_threshold: float = 0.2 # TODO: Put this in the game config!

#region Inputs to be read by the Character controller
# NOTE: Remember to add these to the RollbackSynchronizer!!!
var input_vector: Vector2 = Vector2.ZERO
var jump_input: bool = false
var sprint_input: bool = false
#endregion

func _input(event: InputEvent) -> void:
	
	# Prevents you from influencing other player characters' control inputs
	if not is_multiplayer_authority():
		return
	
	# Switches between Keyboard or Joypad layouts on different inputs.
	# WARNING: The game might end up hating multiple inputs at the same time...
	# NOTE: Do we need to be checking this on every input event?
	if event is InputEventKey or event is InputEventMouse:
		_joypad_input = false
	else:
		_joypad_input = true

func _gather() -> void:
	# Prevents you from influencing other player characters' control inputs
	if not is_multiplayer_authority():
		return
	
	# Capture the new inputs. Used to compare movement to the old input vectors
	var new_input_vector: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	
	# For only joypads, if the stick was drastically flicked, turn on sprint
	if _joypad_input:
		var _flick_strength: float = abs(new_input_vector.dot(input_vector))
		if _flick_strength > _flick_threshold:
			_sprint_toggle = true
	
	# If we started sprinting through toggle, continue sprinting until input completely stops.
	# Certain states should force exit sprinting too
	if _sprint_toggle:
		sprint_input = true
		if new_input_vector.is_equal_approx(Vector2.ZERO):
			_sprint_toggle = false
			sprint_input = false
	
	# Regular logic for sprinting, where it only continues as long as the
	# sprint key is being held down (ie. the shift key)
	else:
		if Input.is_action_pressed("sprint"):
			sprint_input = true
		else:
			sprint_input = false
	
	input_vector = new_input_vector
	pass
