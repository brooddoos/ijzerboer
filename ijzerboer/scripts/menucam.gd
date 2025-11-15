extends Camera3D
@onready var camera: Camera3D = $"."

var origin:Vector3
var originz
var stength:float = 0.1

func _ready():
	origin = camera.global_position

func _process(_delta):
	var mouse = get_viewport().get_mouse_position()
	var size = get_viewport().get_visible_rect().size
	var mx = (mouse.x / size.x - 0.5) * 2.0
	var my = (mouse.y / size.y - 0.5) * 2.0

	# it uhhh wiggles idfk anymore
	var offset = Vector3(mx * stength, -my * stength, 0)
	camera.global_position = origin + offset
