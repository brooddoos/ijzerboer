extends Control
@onready var splashtext: Label = $VBoxContainer/splashtext

const splashTexts = [ #voeg later mss meer toe, idk
	"im uhhh the iron metal collector man",
	"Man, man, man, ... miserie, miserie",
	"a great source of iron",
	"a not so great source of iron",
	"im picking up metals wow",
]

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	splashtext.text = splashTexts[rng.randi_range(0,len(splashTexts)-1)]

func _process(delta: float) -> void:
	pass
