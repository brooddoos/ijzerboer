extends Node
var time := 50000.0
var last_hour := 0
func _physics_process(delta: float) -> void:
	time += delta * 100
	var seconds = int(time) % 60
	var minutes = (int(time) / 60) % 60 
	var hour = (int(time) / 3600) % 24
	$Time.text = str(hour) + ":" + str(minutes) + ":" + str(seconds)
	var rings = hour % 12
		
	if last_hour != hour:
		last_hour = hour
		if hour > 7 and hour < 23:
			for i in range(0,rings):
				$Bell.play()
				await get_tree().create_timer(1.0).timeout
