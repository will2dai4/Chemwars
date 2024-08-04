extends Area2D

@onready var carbon_b = $CarbonB
@onready var boron_b = $BoronB
@onready var chlorine_b = $ChlorineB
@onready var gold_b = $GoldB
@onready var helium_b = $HeliumB
@onready var hydrogen_b = $HydrogenB
@onready var iron_b = $IronB
@onready var lithium_b = $LithiumB
@onready var mercury_b = $MercuryB
@onready var oxygen_b = $OxygenB
@onready var sodium_b = $SodiumB
@onready var reg_bullet = $RegBullet

const my_scene = preload("res://Characters/bullet.tscn")

@onready var sprite = reg_bullet
var Btype = "regbullet"

var angle = 1
var speed:float = 300
var x_multiplier:float = 0
var y_multiplier:float = 1
var rotated = false

func _ready():
	carbon_b.visible = false
	boron_b.visible = false
	chlorine_b.visible = false
	gold_b.visible = false
	helium_b.visible = false
	hydrogen_b.visible = false
	iron_b.visible = false
	lithium_b.visible = false
	mercury_b.visible = false
	oxygen_b.visible = false
	sodium_b.visible = false
	reg_bullet.visible = false
	
	match Btype:
		"coal":
			sprite = carbon_b
			carbon_b.visible = true
		"boron":
			sprite = boron_b
			boron_b.visible = true
		"chlorine":
			sprite = chlorine_b
			chlorine_b.visible = true
		"gold":
			sprite = gold_b
			gold_b.visible = true
		"helium":
			sprite = helium_b
			helium_b.visible = true
		"hydrogen":
			sprite = hydrogen_b
			hydrogen_b.visible = true
		"iron":
			sprite = iron_b
			iron_b.visible = true
		"lithium":
			sprite = lithium_b
			lithium_b.visible = true
		"mercury":
			sprite = mercury_b
			mercury_b.visible = true
		"oxygen":
			sprite = oxygen_b
			oxygen_b.visible = true
		"sodium":
			sprite = sodium_b
			sodium_b.visible = true
		"regbullet":
			sprite = reg_bullet
			reg_bullet.visible = true

static func new_bullet(Btype: String):
	var new_bullet = my_scene.instantiate()
	new_bullet.Btype = Btype
	print(Btype)
	print()
	return new_bullet

func _physics_process(delta):
	if not rotated:
		sprite.rotate(angle)
		rotated = true
	position.x += speed * x_multiplier * delta
	position.y += speed * y_multiplier * delta

func _on_area_entered(area):
	if area.get_name() == "Bullet":
		
		area.queue_free()
		queue_free()

