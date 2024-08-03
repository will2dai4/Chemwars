extends CharacterBody2D

const MAX_HEALTH = 60

@export var default_move_speed:float = 100
@export var screen_size:Vector2
@onready var gun = $Gun

var bullet = preload("res://Characters/bullet.tscn")
var acting_move_speed = default_move_speed
var health = MAX_HEALTH

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	acting_move_speed = default_move_speed

	var input_direction = Vector2(x_movement, y_movement)
	velocity = input_direction * acting_move_speed
	move_and_slide()
	
	# Determine which sprite is currently active
	
	set_health_bar()
	
	# Clamp the position to keep the character within bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if health <= 0:
		queue_free()
	
func shoot():
	var b = bullet.instantiate()
	add_child(b)
	var theta = get_angle_to(get_global_mouse_position())
	b.x_multiplier = cos(theta)
	b.y_multiplier = sin(theta)
	b.angle = theta
	
func damage(dmg: int):
	health -= dmg

func set_health_bar():
	$HealthBar.value = health
	$HealthLabel.text = "hp: " + str(health)

func _on_area_2d_area_entered(area):
	area.queue_free()
	damage(10)
