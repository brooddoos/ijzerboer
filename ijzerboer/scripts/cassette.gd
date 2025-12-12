extends Control
@onready var cassette: Node3D = $SubViewportContainer/SubViewport/Node3D/Cassette
@onready var animation_player = $SubViewportContainer/SubViewport/Node3D/Cassette/AnimationPlayer
@onready var title: Label3D  = $SubViewportContainer/SubViewport/Node3D/Cassette/label/text
@onready var cassette_start_pos = cassette.position.y
@onready var cassette_up := false
@export var tapes:Dictionary = {
	1: { "title": "Jungle Mixtape\nVOLUME 1", "file":"res://assets/audio/jungle.mp3"},
	2: { "title": "Asleep and Dreaming\nBy: Arcologies ", "file":"res://assets/audio/asleepanddreaming.mp3"},
}
@export var current_tape = 1

var tween #zoda je kn wachten indien nodig

func allTween(transistionType:Tween.TransitionType,object,property:String,vars,time:float): #zoda we nie 10x dezelfde functie opnieuw moete schrijven
	tween = get_tree().create_tween()
	tween.set_trans(transistionType)
	tween.tween_property(object, property, vars, time)

func _ready() -> void:
	animation_player.play("cassette_animation")
	cassette.position.y = cassette_start_pos-0.05

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("info"):
		cassette_up = not cassette_up
		if cassette_up:
			allTween(Tween.TRANS_EXPO,cassette,"position:y",cassette_start_pos - 0.05,0.25)
		else:
			allTween(Tween.TRANS_EXPO,cassette,"position:y",cassette_start_pos,0.25)

	if Input.is_action_just_pressed("cassette"):
		if current_tape != len(tapes):
			current_tape += 1
		else:
			current_tape = 1
		
		allTween(Tween.TRANS_EXPO,cassette,"position:y",cassette_start_pos - 0.1,0.25)
		await tween.finished
		title.text=tapes[current_tape]["title"]
		allTween(Tween.TRANS_EXPO,cassette,"position:y",cassette_start_pos - 0.05,0.25)
		cassette_up = false
		
		$AudioStreamPlayer.stream = load(tapes[current_tape]["file"])
		$AudioStreamPlayer.play()
		
