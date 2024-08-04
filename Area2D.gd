extends Area2D

@onready var sprite = $Sprite2D

var angle = 0
var speed:float = 500
var x_multiplier:float = 0
var y_multiplier:float = 1
var rotated = false
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if not rotated:
		sprite.rotate(angle)
		rotated = true
	position.x += speed * x_multiplier * delta
	position.y += speed * y_multiplier * delta


func _on_area_entered(area):
	if area.get_name() == "Bullet":
		queue_free()
		area.queue_free()
