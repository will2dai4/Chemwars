extends Node2D

@onready var timer = $Timer
@onready var enemy_unit = preload("res://Characters/enemy_unit.tscn")
const FIRE = preload("res://Art/fire.tscn")
const SALT = preload("res://Art/salt.tscn")

var enemy_cooldown:float = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(enemy_cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_fire(location: Vector2):
	var fire = FIRE.instantiate()
	fire.position = location
	add_child(fire)
	print("fired")

func create_salt(location: Vector2):
	var salt = SALT.instantiate()
	salt.position = location
	add_child(salt)

func _on_timer_timeout():
	var en = enemy_unit.instantiate()
	en.position = Vector2(500, 150)
	add_child(en)
	timer.start(enemy_cooldown)
