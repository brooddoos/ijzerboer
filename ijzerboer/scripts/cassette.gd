extends Control
@onready var cassette: Node3D = $SubViewportContainer/SubViewport/Node3D/Cassette
@onready var animation_player = $SubViewportContainer/SubViewport/Node3D/Cassette/AnimationPlayer
@onready var title: Label3D  = $SubViewportContainer/SubViewport/Node3D/Cassette/label/text
@onready var cassette_start_pos = cassette.position.y
@export var tapes:Dictionary = {
	1: { "title": "Ijzerman music\nVOLUME 1", "file":"res://assets/audio/jungle.mp3"},
	2: { "title": "insert very original song title\n", "file":"res://assets/audio/jungle.mp3"},
}
@export var current_tape = 1
func _ready() -> void:
	animation_player.play()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("info"):
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_property(cassette, "position:y", cassette_start_pos + 0.02, 0.15)

	if Input.is_action_just_released("info"):
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_property(cassette, "position:y", cassette_start_pos, 0.15)
	if Input.is_action_just_pressed("cass  ette"):
		if current_tape != 2:
			current_tape = current_tape + 1
		else:
			current_tape = 1
			
		title.text=tapes[current_tape]["title"]
		$AudioStreamPlayer.stream = load(tapes[current_tape]["file"])
		$AudioStreamPlayer.play()
		
