extends Camera3D

@export var camion:Node3D
@export var campos:Node3D

func _physics_process(delta : float):
	var target_pos = lerp(global_position, campos.global_position, 0.1)

	if target_pos.distance_to(camion.global_position) > 10.0:
		target_pos = camion.global_position + (target_pos - camion.global_position).normalized() * 10.0

	global_position = target_pos
	look_at(camion.global_position)
