extends CharacterBody2D
class_name PlayerMain

@onready var state_machine: RewindableStateMachine = $RewindableStateMachine
@onready var player_input: PlayerInput = $PlayerInput
@onready var rollback_synchronizer: RollbackSynchronizer = $RollbackSynchronizer

@export var speed: float = 200
@export var weight: float = 1.0
@export var walk_angle: int = 45

@export var jump_velocity: float = -200
@export var strafe_speed: Vector2 = Vector2(10, 10)

@export var acceleration: float = 10.0
@export var friction: float = 30.0
@export var stop_speed: float = 50.0

@onready var current_weight: float = weight

func _ready() -> void:
	state_machine.state = &"IdleState"
