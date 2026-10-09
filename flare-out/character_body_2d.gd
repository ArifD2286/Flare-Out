extends CharacterBody2D

# Notes:
# View of jet would be top view and the jet's nose facing the right, it is also travelling in a straight line to the right

@export var max_forward_speed: float = 400.0
@export var max_backward_speed: float = 150.0
# thhrust change rate is for the rate of change for thrust when pressing [SHIFT] or [CTRL]/[CONTROL]
@export var thrust_change_rate: float = 300.0
# acceleration is for the change of speed when thrust level is changed to give the sensation of the
# presence of momentum
@export var acceleration: float = 200.0
@export var roll_turn_rate: float = 40.0
@export var yaw_turn_rate: float = 15.0
@export var max_heading_deg: float = 45.0

# There will be 2 roll modes for each side, so 4 total
const max_roll: int = 2
var roll_level: int = 0

# target speed var would be the target value for the jet's speed
var target_speed: float = 0.0
var current_speed: float = 0.0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("inc_trhust"):
		target_speed += thrust_change_rate * delta
	if Input.is_action_pressed("dec_thrust"):
		target_speed -= thrust_change_rate * delta
		
	# [clampf(value, min, max)] keeps the throttle between full reverse and full forward
	target_speed = clampf(target_speed, -max_backward_speed, max_forward_speed)
	current_speed = move_toward(current_speed, target_speed, acceleration * delta)
	velocity = Vector2.UP.rotated(rotation) * current_speed
	
	move_and_slide()
	
	if Input.is_action_just_pressed("roll_right"):
		roll_level = clamp(roll_level + 1, -max_roll, max_roll)
	if Input.is_action_just_pressed("roll_left"):
		roll_level = clamp(roll_level - 1, -max_roll, max_roll)
