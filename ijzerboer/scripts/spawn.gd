extends Node3D
var iron = load("res://scenes/Iron.tscn")
func spawn_iron():
	#Get random spawn location
	var spawnlocations = get_children()
	var spawnlocation = spawnlocations.pick_random()
	iron = iron.instantiate()
	spawnlocation.add_child(iron) 
	iron.global_transform = spawnlocation.global_transform
	print("iron spawned")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_iron() 
