extends CharacterBody2D

const MAX_HEALTH = 100

@export var default_move_speed:float = 200
@export var screen_size:Vector2
@onready var marker2d = $Marker2D
@onready var coal_sprite = $Marker2D/Coal
@onready var chlorine_sprite = $Marker2D/Chlorine
@onready var gold_sprite = $Marker2D/Gold
@onready var gun = $Marker2D/Gun

var bullet = preload("res://Characters/bullet.tscn")
var diagonal_move_speed:float = default_move_speed / 2
var acting_move_speed = default_move_speed
var health = MAX_HEALTH

func _ready():
	screen_size = get_viewport_rect().size
	
	# Hide all sprites initially
	coal_sprite.visible = false
	chlorine_sprite.visible = false
	gold_sprite.visible = false
	
	# Set the appropriate sprite based on the global variable
	match Global.currently_selected:
		0:
			coal_sprite.visible = true
			print("0")
		1:
			chlorine_sprite.visible = true
			print("1")
		2:
			gold_sprite.visible = true
			print("2")

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
	
func shoot():
	var b = bullet.instantiate()
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
