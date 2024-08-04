extends Area2D

var fire_time = 4
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(fire_time)

func _on_timer_timeout():
	queue_free()
