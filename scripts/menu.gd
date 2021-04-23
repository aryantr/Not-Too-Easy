extends Control

var main_scene

func _ready():
	main_scene = preload("res://scenes/main.tscn")
	var h_score = saveload.load_game_score()
	if h_score > 0:
		get_node("VBoxContainer/Label").text = "highscore : " + str(h_score)
	

func _on_Play_pressed():
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene_to(main_scene)


func _on_Exit_pressed():
	get_tree().quit()
