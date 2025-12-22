extends Control
@onready var buttons = [$VBoxContainer2/CustomLicensePlate/LicensePlateButton, $VBoxContainer2/UpgradeLoad/CargoButton, $VBoxContainer2/UpgradeEngine/EngineButton]
func _ready() -> void:
	var area_3d = $"/root/Game/Garage/Area3D"
	area_3d.entered.connect(_on_body_entered)
	area_3d.exited.connect(_on_body_exited)
	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button))
func _on_body_entered():
	self.show()
	for button in buttons:
		var price = button.get_meta("price")
		button.text = str(price)  + "BEF"
		if price < Gamestate.BEF:
			button.disabled = false
		else:
			button.disabled = true
func _on_body_exited():
	self.hide()
func _on_button_pressed(button):
	match button.name:
		"LicensePlateButton":
			Gamestate.BEF -= button.get_meta("price")
			print("test1")
		"CargoButton":
			Gamestate.BEF -= button.get_meta("price")
			Gamestate.car_stats["max_cargo"] += 50
			print("test2")
		"EngineButton":
			Gamestate.BEF -= button.get_meta("price")
			print("test3")
