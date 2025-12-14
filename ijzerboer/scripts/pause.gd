extends Control

var paused := false
var inTransition := false

func _ready() -> void:
	$".".position.y = 730.0
	hide()

var tween

func allTween(transistionType:Tween.TransitionType,object,property:String,vars,time:float): #zoda we nie 10x dezelfde functie opnieuw moete schrijven
	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(transistionType)
	tween.tween_property(object, property, vars, time)

func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if not inTransition:
			inTransition = true
			if not paused:
				paused = true
				get_tree().paused = true
				show()
				
				allTween(Tween.TRANS_EXPO,$".","position:y",0,0.25)
				await tween.finished
				tween.kill()
				inTransition = false
			else:
				allTween(Tween.TRANS_EXPO,$".","position:y",730,0.25)
				await tween.finished
				inTransition = false
				tween.kill()
				
				paused = false
				get_tree().paused = false
				hide()


func _on_button_pressed() -> void:
	get_tree().paused = false
	
	var mainmenu = load("res://scenes/Menu.tscn") as PackedScene
	get_tree().change_scene_to_packed(mainmenu)
