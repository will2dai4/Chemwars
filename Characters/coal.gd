extends CharacterBody2D

@export var move_speed:float = 200
@export var screen_size:Vector2

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if x_movement != 0 and y_movement != 0:
		x_movement *= sqrt(2)
		y_movement *= sqrt(2)
		
	var input_direction = Vector2(x_movement, y_movement)
	
	velocity = input_direction * move_speed
	move_and_slide()
	
	# Clamp the position to keep the character within bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)