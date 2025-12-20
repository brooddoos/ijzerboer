extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"/root/Game/UI/Control/Cargo".text = str(Gamestate.cargo) + " / " + str(Gamestate.car_stats["max_cargo"]) + " KG"
	var models = $Models.get_children()
	var model = models.pick_random()
	model.show()
	$Area3D.entered.connect(_on_body_entered)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered():
	if Gamestate.cargo < Gamestate.car_stats["max_cargo"]:
		print("ijzer gevonden")
		Gamestate.cargo += 1
		self.queue_free()
		$"/root/Game/SpawnLocations".spawn_iron( )
