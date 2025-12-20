extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var models = $Models.get_children()
	var model = models.pick_random()
	model.show()
	print("iron visible")
	$Area3D.entered.connect(_on_body_entered)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered():
	print("ijzer gevonden")
	Gamestate.cargo += 1
	self.queue_free()
