extends Camera3D
@onready var camera: Camera3D = $"."

var origin:Vector3
var originz
var stength:float = 0.1

func _ready():
	origin = camera.global_position

func _process(_delta):
	var mouse = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().get_visible_rect().size
	var mx = (mouse.x / viewport_size.x - 0.5) * 2.0
	var my = (mouse.y / viewport_size.y - 0.5) * 2.0

	var offset = Vector3(mx * stength, -my * stength, 0)
	camera.global_position = origin + offset
