extends CharacterBody2D

const MAX_HEALTH = 100
const TICK = 0.5

const element_list = ["coal", "chlorine", "gold", "helium", "hydrogen", "iron", "lithium", "mercury", "oxygen", "sodium", "boron", "silver"]

@export var default_move_speed:float = 200
@export var screen_size:Vector2
@onready var marker2d = $Marker2D
@onready var coal_sprite = $Marker2D/Coal
@onready var chlorine_sprite = $Marker2D/Chlorine
@onready var gold_sprite = $Marker2D/Gold
@onready var iron_sprite = $Marker2D/Iron
@onready var diamond_sprite = $Marker2D/Diamond
@onready var helium_sprite = $Marker2D/Helium
@onready var hydrogen_sprite = $Marker2D/Hydrogen
@onready var lithium_sprite = $Marker2D/Lithium
@onready var mercury_sprite = $Marker2D/Mercury
@onready var silver_sprite = $Marker2D/Silver
@onready var oxygen_sprite = $Marker2D/Oxygen
@onready var sodium_sprite = $Marker2D/Sodium
@onready var boron_sprite = $Marker2D/Boron
@onready var gun = $Marker2D/Gun

@onready var fire_timer = $FireTimer

var bullet = load("res://Characters/bullet.tscn").instantiate()
var diagonal_move_speed:float = default_move_speed / 2
var acting_move_speed = default_move_speed
var health = MAX_HEALTH

func _ready():
	screen_size = get_viewport_rect().size
	
	# Hide all sprites initially
	coal_sprite.visible = false
	chlorine_sprite.visible = false
	gold_sprite.visible = false
	iron_sprite.visible = false
	diamond_sprite.visible = false
	helium_sprite.visible = false
	hydrogen_sprite.visible = false
	lithium_sprite.visible = false
	mercury_sprite.visible = false
	boron_sprite.visible = false
	sodium_sprite.visible = false
	oxygen_sprite.visible = false
	silver_sprite.visible = false
	
	# Set the appropriate sprite based on the global variable
	match Global.currently_selected:
		0:
			coal_sprite.visible = true
		1:
			chlorine_sprite.visible = true
		2:
			gold_sprite.visible = true
		3:
			helium_sprite.visible = true
		4:
			hydrogen_sprite.visible = true
		5:
			iron_sprite.visible = true
		6:
			lithium_sprite.visible = true
		7:
			mercury_sprite.visible = true
		8:
			oxygen_sprite.visible = true
		9:
			sodium_sprite.visible = true
		10:
			boron_sprite.visible = true
		11:
			silver_sprite.visible = true
		

func _physics_process(delta):
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if x_movement != 0 and y_movement != 0:
		acting_move_speed = diagonal_move_speed
	else:
		acting_move_speed = default_move_speed

	var input_direction = Vector2(x_movement, y_movement)
	velocity = input_direction * acting_move_speed
	move_and_slide()
	
	# Determine which sprite is currently active
	var current_sprite = get_current_visible_sprite()
	
	if current_sprite:
		if (get_global_mouse_position().x < position.x):
			current_sprite.flip_h = false
			gun.flip_h = true
		else:
			current_sprite.flip_h = true
			gun.flip_h = false
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("ability1"):
		use_ability1()

	set_health_bar()
	
	# Clamp the position to keep the character within bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if health <= 0:
		get_tree().change_scene_to_file("res://Game Level/end_screen.tscn")
	
func shoot():
	var b = bullet.new_bullet(element_list[Global.currently_selected])
	add_child(b)
	var theta = get_angle_to(get_global_mouse_position())

	b.x_multiplier = cos(theta)
	b.y_multiplier = sin(theta)
	b.angle = theta
	
func use_ability1(): # personal ability for each element
	pass

func damage(dmg: int):
	health -= dmg

func set_health_bar():
	$HealthBar.value = health
	$HealthLabel.text = "hp: " + str(health)

func get_current_visible_sprite():
	for child in marker2d.get_children():
		if child.visible:
			return child
	return null

func get_type():
	return element_list[Global.currently_selected]

func _on_area_2d_area_entered(area):
	if area.get_parent() != self: 
		if area.get_name() == "Bullet":
			area.queue_free()
			damage(10)
		if area.get_name() == "Fire":
			fire_timer.start(TICK)


func _on_fire_timer_timeout():
	damage(5)
