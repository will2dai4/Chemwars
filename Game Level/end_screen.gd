extends Control

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Game Level/main_menu.tscn")


func _on_exit_game_pressed():
	get_tree().quit()
