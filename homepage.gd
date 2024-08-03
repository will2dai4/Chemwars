# Homepage.gd
extends Control

func _ready():
	$StartButton.connect("pressed", self, "_on_start_button_pressed")

func _on_start_button_pressed():
	get_tree().change_scene("res://Gameplay.tscn")
