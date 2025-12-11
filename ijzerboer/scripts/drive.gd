extends Node3D

@onready var car_mesh = $Car
@onready var ground_ray = $Car/RayCast3D
##@onready var right_wheel = $Car/VehicleWheel3D
## @onready var left_wheel = $Car/VehicleWheel3D2

# Movement settings
var default_acceleration = 20
var accel_multiplier = 0.75 # for drifting
var default_steering = 20.0  # degrees
var steer_multiplier = 3.0 # for drifting

# Input
var speed_input := 0.0
var turn_input := 0.0

var steering:float # added so you only need to update one variable (see settings /\)
var acceleration:float # same here

func _ready() -> void:
	steering = default_steering
	acceleration = default_acceleration

func _physics_process(delta):
	# Stick car mesh to the ball's position
	$Car.global_position = $Ball.global_position
	var speed = $Ball.linear_velocity.length() * 3.6
	int(speed)
	print(speed)
	# Input
	speed_input = Input.get_axis("brake", "accelerate") * acceleration
	turn_input = deg_to_rad(steering) * Input.get_axis("steer_right", "steer_left")
	# Apply movement force
	if ground_ray.is_colliding():
		var forward = car_mesh.transform.basis.z
		$Ball.apply_central_force(forward * speed_input)
	if not ground_ray.is_colliding():
		return

	# Rotate wheels visually
	##right_wheel.rotation.y = turn_input
	##left_wheel.rotation.y = turn_input

	# Turn the car mesh visually only when moving
	car_mesh.rotate_y(turn_input * delta)

func _process(delta):
	#honk
	if Input.is_action_just_pressed("honk"):
		$Car/AudioStreamPlayer3D.play()
	if Input.is_action_just_pressed("lights"):
		$Car/Mesh/FrontLeftLight.visible = not $Car/Mesh/FrontLeftLight.visible
		$Car/Mesh/FrontRightLight.visible = not $Car/Mesh/FrontRightLight.visible
	if Input.is_action_just_pressed("drift"):
		steering = default_steering*steer_multiplier
		acceleration = default_acceleration*accel_multiplier
	if Input.is_action_just_released("drift"):
		steering = default_steering
		acceleration = default_acceleration
