extends Control

@onready var label_2 = $Label2

var characters = []

func _ready():
	for nameOfCharacter in get_tree().get_nodes_in_group("Characters"):
		characters.append(nameOfCharacter)
		
func _process(delta):
	label_2.text = characters[Global.currently_selected].name

func _on_coal_pressed():
	Global.currently_selected = 0


func _on_chlorine_pressed():
	Global.currently_selected = 1


func _on_gold_pressed():
	Global.currently_selected = 2


func _on_helium_pressed():
	Global.currently_selected = 3


func _on_hydrogen_pressed():
	Global.currently_selected = 4


func _on_iron_pressed():
	Global.currently_selected = 5


func _on_lithium_pressed():
	Global.currently_selected = 6


func _on_mercury_pressed():
	Global.currently_selected = 7


func _on_oxygen_pressed():
	Global.currently_selected = 8


func _on_silver_pressed():
	Global.currently_selected = 9


func _on_select_button_pressed():
	get_tree().change_scene_to_file("res://Game Level/main_menu.tscn")
