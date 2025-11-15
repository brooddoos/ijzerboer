extends MeshInstance3D
@onready var startpoint_1: Node3D = $"../startpoint1"
@onready var endpoint_1: Node3D = $"../endpoint1"
@onready var endpoint_2: Node3D = $"../endpoint2"
@onready var startpoint_2: Node3D = $"../startpoint2"
@onready var car: MeshInstance3D = $"."
@export var speed = 10

# uhh
var rng = RandomNumberGenerator.new()
var destination:Vector3 = Vector3(0,0,0)
#related to driving state
var driving = false
var isDrun = false
# related to arriving and departing
var counter = 0
var arrivedCount = 0
var offset = 600

func randint(minimu:int, maximu:int) -> int: #im used to python :P
	return rng.randi_range(minimu, maximu)

func _ready() -> void:
	car.position = startpoint_1.position
	car.rotation = startpoint_2.rotation
	destination = endpoint_1.position

func _process(delta: float) -> void:
	counter += 1
	var direction = (destination - car.position)
	if (direction.length() < 0.1 or direction.length() > 100) and arrivedCount + offset <= counter: #ge zijt aangekomen maat
		if destination == endpoint_1.position:
			car.position = startpoint_2.position
			car.rotation = startpoint_2.rotation
			destination = endpoint_2.position
		elif destination == endpoint_2.position:
			car.position = startpoint_1.position
			car.rotation = startpoint_1.rotation
			destination = endpoint_1.position
		else:
			push_error("gvd auto zit te malfunctioneren")
			
		arrivedCount = counter
		offset = randint(0,750)
		return
		
	if arrivedCount + offset <= counter: 
		direction = direction.normalized()
		car.look_at(destination, Vector3.UP)
		if isDrun:
			car.rotation.y -= deg_to_rad(180+randint(-90,90))
			car.position += direction * speed*2 * delta
		else:
			car.rotation.y -= deg_to_rad(180)
			car.position += direction * speed * delta
	else:
		isDrun = randint(0,2) == 1
		
	
