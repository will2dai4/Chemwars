extends CharacterBody2D

const MAX_HEALTH = 60

@export var default_move_speed:float = 50
@export var screen_size:Vector2
@export var idle_time:float = 3
@onready var timer = $Timer
@onready var player = get_parent().get_node("Player")

@onready var coal_sprite = $Coal
@onready var chlorine_sprite = $Chlorine
@onready var gold_sprite = $Gold
@onready var iron_sprite = $Iron
@onready var diamond_sprite = $Diamond
@onready var helium_sprite = $Helium
@onready var hydrogen_sprite = $Hydrogen
@onready var lithium_sprite = $Lithium
@onready var mercury_sprite = $Mercury
@onready var silver_sprite = $Silver
@onready var oxygen_sprite = $Oxygen
@onready var sodium_sprite = $Sodium
@onready var boron_sprite = $Boron
@onready var gun = $Gun


var player_position
var target_position

var bullet = preload("res://Characters/bullet.tscn")
var acting_move_speed = default_move_speed
var health = MAX_HEALTH

func _ready():
	screen_size = get_viewport_rect().size
	timer.start(idle_time)
	
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
	
	var rng = RandomNumberGenerator.new()
	var current = rng.randi_range(0, 11)
	
	match current:
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
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	var sprite = get_current_visible_sprite()
	
	if position.distance_to(player_position) > 100:
		velocity = target_position * default_move_speed
	else:
		velocity = Vector2(0, 0)
	if position.x < player_position.x:
		sprite.flip_h = false
		gun.flip_h = true
	else:
		sprite.flip_h = true
		gun.flip_h = false
		
	acting_move_speed = default_move_speed

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
	var theta = get_angle_to(player_position)
	b.x_multiplier = cos(theta)
	b.y_multiplier = sin(theta)
	b.angle = theta
	health += 10
	
func damage(dmg: int):
	health -= dmg

func set_health_bar():
	$HealthBar.value = health
	$HealthLabel.text = "hp: " + str(health)

func _on_area_2d_area_entered(area):
	if area.get_parent() != self:
		area.queue_free()
		damage(10)

func _on_timer_timeout():
	shoot()
	timer.start()
	
func get_current_visible_sprite():
	for child in get_children():
		if child.visible:
			return child
	return null
