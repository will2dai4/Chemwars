extends CharacterBody2D

const MAX_HEALTH = 60

@export var default_move_speed:float = 50
@export var screen_size:Vector2
@export var idle_time:float = 3
@onready var sprite = $Enemy
@onready var gun = $Gun
@onready var timer = $Timer
@onready var player = get_parent().get_node("Player")

var player_position
var target_position

var bullet = preload("res://Characters/bullet.tscn")
var acting_move_speed = default_move_speed
var health = MAX_HEALTH

func _ready():
	screen_size = get_viewport_rect().size
	timer.start(idle_time)

func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
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
