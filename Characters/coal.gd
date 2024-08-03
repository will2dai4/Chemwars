extends CharacterBody2D


@export var move_speed:float = 200


func _physics_process(delta):
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if x_movement != 0 and y_movement != 0:
		x_movement *= sqrt(2)
		y_movement *= sqrt(2)
		
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	velocity = input_direction * move_speed

	move_and_slide()
