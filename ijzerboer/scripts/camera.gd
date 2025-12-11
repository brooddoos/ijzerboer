extends Camera3D

@export var camion:Node3D
@export var campos:Node3D

func _physics_process(delta : float):
  global_position = lerp($".".position, campos.global_position , 0.05)
  look_at(camion.global_position)
