extends Node3D
func _ready() -> void:
	$Area3D.entered.connect(_on_body_entered)
	$Area3D.exited.connect(_on_body_exited)
func _on_body_entered():
	$Control.show()
func _on_body_exited():
	$Control.hide()
