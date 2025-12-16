extends Control
@onready var settings: PanelContainer = $Settings
@onready var _3_dsplashtext: Label3D = $"../../Logo/3dsplashtext"
@onready var buttons: PanelContainer = $Buttons
@export var scene:PackedScene
const splashTexts = [ #voeg later mss meer toe, idk
	"Man, man, man, miserie, miserie, miserie!",
	"Hier zijn geen ijzertekorten te bespeuren!",
	"Mijnen infra -fra -fra -fra infrastructuur!",
	"Nu ook op Windows 98!",
	"Tegels, natuursteen, parket, Imp... Ah just nee, miljaar.",
	"Kovy Deukens, wij maken uw België in keuken",
	"Zal't gaan ja?!",
	"Mijn gedacht."
]

var rng = RandomNumberGenerator.new()
func _ready() -> void:
	_3_dsplashtext.text = splashTexts[rng.randi_range(0,len(splashTexts)-1)]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("drift"):
		_3_dsplashtext.text = splashTexts[rng.randi_range(0,len(splashTexts)-1)]

func _on_play_pressed() -> void:
	##Transition.changescene()
	get_tree().change_scene_to_packed(scene)
func _on_options_pressed() -> void:
	buttons.visible = !buttons.visible
	settings.visible = !settings.visible
	
func _on_exit_pressed() -> void:
	get_tree().quit()
