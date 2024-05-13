extends Sprite2D

@onready var muzzle = $Muzzle
@onready var rng = RandomNumberGenerator.new()
@onready var default_rotation_degrees = rotation_degrees

const CANNONBALL = preload("res://scenes/cannonball.tscn")
	
func _process(delta):
	pass
	
func fire(deviation = 2):
	var ci = CANNONBALL.instantiate()
	ci.global_transform = muzzle.global_transform
	ci.rotation_degrees += rng.randfn (0, deviation)
	get_tree().get_root().add_child(ci)
	
func point_to(point_position):
	rotation = transform.looking_at(point_position).get_rotation()
	
	var rotation_clamped = clampf(rotation_degrees, default_rotation_degrees - 10, default_rotation_degrees + 10)
	rotation_degrees = rotation_clamped
	
