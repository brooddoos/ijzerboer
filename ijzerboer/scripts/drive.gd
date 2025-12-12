extends Node3D

@onready var car = $Car
@onready var ground_ray = $Car/RayCast3D
@onready var front_right_wheel = $Car/Mesh/FrontRightWheel
@onready var front_left_wheel = $Car/Mesh/FrontLeftWheel
@onready var ball = $Ball

# Movement settings
var default_acceleration = 20
var accel_multiplier = 0.75 # for drifting
var default_steering = 30.0  # degrees
var steer_multiplier = 3.0 # for drifting
var turn_minimum = 0.75 # minimum speed to turn

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
	car.global_position = ball.global_position
	# Spedometer
	var speed = int(ball.linear_velocity.length() * 3.6)
	$"../UI/Spedometer".text = str(speed   )
	
	# Input
	speed_input = Input.get_axis("brake", "accelerate") * acceleration
	turn_input = deg_to_rad(steering) * Input.get_axis("steer_right", "steer_left")
	# Apply movement force
	if turn_minimum > ball.linear_velocity.length():
		pass
		#nog maken!!!!
	if ground_ray.is_colliding():
		var forward = car.transform.basis.z
		ball.apply_central_force(forward * speed_input)
	if not ground_ray.is_colliding():
		return

	front_right_wheel.rotation.y = turn_input
	front_left_wheel.rotation.y = turn_input+deg_to_rad(180)
	car.rotate_y(turn_input * delta)

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
