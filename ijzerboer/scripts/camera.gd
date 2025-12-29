extends Camera3D

@export var car:Node3D
@export var campos:Node3D

func _physics_process(_delta : float):
	var target_pos = lerp(global_position, campos.global_position, 0.1)

	if target_pos.distance_to(car.global_position) > 10.0:
		target_pos = car.global_position + (target_pos - car.global_position).normalized() * 10.0

	global_position = target_pos
	look_at(car.global_position)
