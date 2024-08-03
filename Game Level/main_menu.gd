extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Game Level/game_stage.tscn")


func _on_character_pressed():
	get_tree().change_scene_to_file("res://Game Level/character_select.tscn")


func _on_exit_pressed():
	get_tree().quit()
